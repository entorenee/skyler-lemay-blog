---
title: 'Functors and Monads - 30DaysofFP Week 3'
slug: 'functors-and-monads-30daysoffp-week-3'
draft: false
publishDate: '2019-09-03'
categories: ['Web Development']
tags: ["functional-programming","javascript"]
series: ['30 Days of Functional Programming']
---
![Functors and Monads - 30DaysofFP Week 3](images/abstract-water-rings.jpg#center)

Functors and monads may sound like some dark secret ingredient from the recesses of functional programming. For our purposes we will begin to approach them as data types that follow a base set of rules. In this post we will dive into working definitions for functors and monads as well as a working example tying them all together.

## What is a functor

A functor is a type which contains a `map` function and adheres to several rules. At their core, they are containers which encapsulate a value. The map function reaches into the container, performs an operation on the inner value, and ultimately returns it back to the container. Arrays in JavaScript are actually functors. Surprise!

```javascript
const double = x => x * 2

const arr = [7, 3, 12, 5]
const dblArr = arr.map(double) // [ 14, 6, 24, 10 ]
```

The array type has a `map` method which accepts a function to perform against the values inside of it. After the operation is completed, the new values are returned back to the container as a new array. This makes it a functor. We can also create our own Functors, keeping in mind these two rules. Here we will create a `Container` functor which holds a value. This code has been adapted from Dr Frisby's [Mostly Adequate Guide to Functional Programming](https://mostly-adequate.gitbooks.io/mostly-adequate-guide/). If you are interested in learning more about functional programming overall, including functors and monads, I highly recommend reading this free book.

```javascript
const add = x => y => x + y

class Container {
  static of(x) {
    return new Container(x)
  }

  constructor(x) {
    this.$value = x
  }

  map(fn) {
    return Container.of(fn(this.$value))  
  }
} 

console.log(Container.of(2).map(add(2)))
// Container { '$value': 4 }
```

Here we have a basic functor which holds a value in closure. Each time we run `map` we are given a new instance of the container with the current value. This functor is basic, but serves as the building block for more complex functors.

## What is a Monad

A monad is a functor which adheres to some additional rules. All monads must contain an `of` method, similar to our container example above. This method instantiates the container with a value so that it can immediately be mapped against. A functor which implements the `of` method is known as a *pointed functor*.

In some situations, functors can become nested within each other. This requires additional calls to `map` to unwrap these layers before reaching the inner value. This is mitigated through a `join` method to flatten the extra layer. A basic implementation of the `Maybe` type can help illustrate this.

```javascript
class Maybe {
  static of(x) {
    return new Maybe(x)
  }

  get isNothing() {
    return this.$value === null || this.$value === undefined
  }

  constructor(x) {
    this.$value = x
  }

  join() {
    return this.isNothing ? Maybe.of(null) : this.$value
  }

  map(fn) {
    return this.isNothing ? this : Maybe.of(fn(this.$value))
  }

  inspect() {
    return this.isNothing ? 'Nothing' : `Just(${this.$value})`
  }
}

const nestedMaybe = Maybe.of(Maybe.of(3))
// Maybe(Maybe(3))

nestedMaybe.join()
// Maybe(3)
```

The Maybe type is a monad which tracks two potential states of the container. Either the container can `Just` have a value, or it can be `Nothing`. The `Nothing` differs from usage of `null` or `undefined` in JavaScript. With those cases we need to guard against performing operations that are not valid, such as accessing a property from `undefined`. The upcoming [optional chaining](https://github.com/tc39/proposal-optional-chaining) and [null coalescing](https://github.com/tc39/proposal-nullish-coalescing) features currently in stage 3 hope to mitigate some of this. The Maybe type behaves differently. If it's current value is `Nothing` any subsequent `map` calls are bypassed. As long as the Maybe type stays in the `Just` case, it will continue to execute the `map` calls. When we are ready to pull the value out of the Maybe type, we can also provide a fallback value for the `Nothing` leg.

Maybe types are useful when the structure of the data is not known at runtime. An example of this is REST calls. Since there is no data contract in REST, a change in the backend structure can result in previously relied upon keys not being present. We expect them to be there in the success case, but they may not be.

## Putting it all Together

Now that we know what a monad and functor is, why does it actually matter? Recently I have been experimenting with a functional wrapper around `fetch` calls with currying. This code example uses the [crocks library](https://crocks.dev/docs/getting-started.html), which provides many functional utilities including the Maybe type discussed above. You can find the [running example of the code](https://codesandbox.io/s/monad-experimentation-iopyr) below on Code Sandbox.

```javascript
import Async from 'crocks/Async'
import chain from 'crocks/pointfree/chain'
import compose from 'crocks/helpers/compose'
import curry from 'crocks/helpers/curry'
import getProp from 'crocks/Maybe/getProp'
import map from 'crocks/pointfree/map'
import maybeToArray from 'crocks/Maybe/maybeToArray'

const safeFetch = curry((baseUrl, endpoint, options) =>
  Async((reject, resolve) => {
    fetch(`${baseUrl}/${endpoint}`, options)
      .then(res => res.json())
      .then(resolve)
      .catch(reject)
  })
)

const printRepos = repos => {
  const list = document.getElementById('repo-list');
  repos.forEach(repo => {
    const li = document.createElement('li');
    li.innerHTML = repo;
    list.append(li);
  })
}

const fetchGithub = safeFetch('https://api.github.com');
const fetchEntorenee = fetchGithub('users/entorenee/repos')({});

fetchEntorenee.fork(
  console.log,
  compose(
    printRepos,
    chain(maybeToArray),
    map(getProp('name'))
  )
)
```

This example is using two different data types: Async and Maybe. The Maybe type is a Monad according to the rules discussed above. Async behaves similar to a promise, in that it receives a resolved and rejected arguments. However, they are reversed with rejected coming first. Using the Async type, we delay the execution of this function until later. To run it, we call the `fork` method and provide two functions, one to run on the rejected case, and the other to run on the success case.

In our success case we compose a series of functions to run against the data result. We first run `getProp` to pull off the `name` property of each object in the data array. This function returns a Maybe type. If the property is found, it is placed in the `Just` leg, otherwise the Maybe's value is `Nothing`. The `chain` function handles calling `map` and immediately calling `join` on the result. This is useful for actions which will nest types, and helps us avoid calling both methods individually. The `maybeToArray` utility from crocks provides a means of converting an array of Maybe types to a regular array. If the item in the array is a `Just` type it will be replaced with it's inner value. If the item in the array is a `Nothing` type, it will not be added to resultant array. Given an array of `Nothing` types, this function will return an empty array. Lastly, we pass the array of repository names to the `printRepos` function and display them in the DOM.

## TLDR

- Functors are a data type which contains a `map` method and follow several rules
- A functor which contains an `of` method to immediately instantiate it is a *pointed functor*.
- A monad has additional rules beyond a functor. They must be pointed functors, but also utilize a `join` method to flatten nested types

Functors and monads can provide additional utility and types when working with JavaScript. In the end they are containers which serve a specific purpose and follow a series of rules. There are many other methods that they may contain, but these core methods are the required basis for their classification.
