---
title: 'What is a Side Effect Anyway? - 30DaysofFP Week 2'
slug: 'what-is-a-side-effect-anyway-30daysoffp-week-2'
draft: false
publishDate: '2019-08-19'
categories: ['Web Development']
tags: ["functional-programming"]
series: ['30 Days of Functional Programming']
---
![What is a Side Effect Anyway? - 30DaysofFP Week 2](images/abstract-spiral-cannon-beach.jpg#center)

Managing side effects is a core principle of functional programming. The existence of side effects can make a program more volatile, error prone, and harder to reason about. In this post, we'll dive into what side effects (and side causes) are, how to manage them, and functional purity.

## What is a Side Effect

A side effect occurs when a function changes something outside of itself. This could be mutating a global variable, pushing data into an array, tracking application state, and more. An application must have side effects in order to run, or else there would be no feedback that it ran in the first place. Writing to the DOM, emitting a console.log, and making an API call are all side effects. As such they cannot be eliminated entirely. Functional programming seeks to minimize them as much as possible, controlling when and how they occur.

Side effects which alter application state make functions *non-deterministic*. In other words, calling a function with the same input multiple times in sequence does not result in the same output or effect. This problematic, as it increases the surface area for bugs and makes it harder to reason about what a function is doing. Take this example:

```javascript
const results = []

const addToResults = x => results.push(x)

addToResults(2)
console.log(results); // [2]

addToResults(2)
console.log(results); // [2, 2]
```

Here our function `addToResults` is pushing directly onto our results array. This is outside of the function's scope and is a side effect. This function also has no direct return. While this may not seem problematic in this example, the complexity increases as the function grows, calls other functions, or lives in a different module. Debugging or understanding this programming approach requires the developer to trace through the function call stack, seeing what pieces of state were mutated. This is less than ideal, and additionally ties functions to specific implementation details.

The existence of side effects in this function make it *impure*. The purity of a function is determined by it's absence of side effects or side causes. Pure functions are desirable, because they ensure that we will always get the same output given the same input. This allows for greater reuse, composition, and certainty. Impure functions also impact the purity of other functions. If a function calls or relies on an impure function, it too is impure.

## How Are Side Effects Managed

These side effects can be managed through directly outputting a new instance of the results array. This eliminates the side effect and makes the function calls *deterministic*. We can be confident that if we call the function with the same arguments we will receive the same results.

```javascript
const addToResults = (arr, x) => arr.concat(x)

const results = []

console.log(addToResults(results, 2)) // [2]

const newResults = addToResults(results, 2)
console.log(newResults) // [2]
```

Now we directly pass in our current results array and concat the new value onto it. This returns a new array directly rather than mutating our variable outside the scope of the function. We have also replaced our method of `push` for `concat` to favor immutable data structures, but more on that a little later on. We can store the result of this operation onto a new variable, or call additional functions off the result, without needing to worry about those changes impacting dependents on a global state.

## What about Side Causes

Side causes are another area of functional impurity. They exist when a function directly *relies upon* a value that it does not receive directly as an argument. The existence of side causes also make a function impure.

```javascript
let y = 5

const add = x => x + y

console.log(add(2)) // 7

y = 10

console.log(add(2)) // 12
```

Here we have a variable which impacts the output value of our sum function, but is not an explicit output. The function is relying on this side cause to be in the application's state. However, even in this simple example, changing the value of the side cause impacts the output of our function. This makes our function impure.  In order to resolve this issue, we need to make `y` an explicit input as an argument.

```javascript
const add = (x, y) => x + y

console.log(add(2, 5)) // 7

console.log(add(2, 10)) // 12
```

Now our function is pure and does not rely on external state in the application. Pure functions are also easier to test. Since they are not dependent on the application's state, they can be exported and tested independently. This is another example of how pure functions result in more reusable code.

## Favor value immutability

Functional programming also favors immutable values. When an argument is passed to a function, generally JavaScript passes on it's value. However, in the case of objects and arrays, the function receives a *reference* to the original object. This can result in some sticky situations if the values are mutated.

```javascript
const recipe = {
  name: 'Risotto',
  ingredients: ['rice', 'stock'],
}

const recipe2 = recipe

const addIngredients = (recipe, ...ingredients) =>
  recipe.ingredients.push(...ingredients)

addIngredients(recipe2, 'onions', 'butter')
console.log(recipe) // { name: 'Risotto', ingredients: ['rice', 'stock', 'onions', 'butter'] }
console.log(recipe2) // { name: 'Risotto', ingredients: ['rice', 'stock', 'onions', 'butter'] }
console.log(recipe === recipe2) // true
```

In this example `recipe2` references the original `recipe` object. They are not separate objects. Mutating one object impacts the other object, because they both point to the same reference. This is undesirable, and makes our code harder to reason about. If we need to use a previous copy of the object, this mutation makes it impossible. In order to combat this, we need to make a copy of our object before mutating it.

```javascript
const recipe = {
  name: 'Risotto',
  ingredients: ['rice', 'stock'],
}

const addIngredients = (recipe, ...ingredients) => ({
  ...recipe,
  ingredients: recipe.ingredients.concat(ingredients)
})

const recipe2 = addIngredients(recipe, 'onions', 'butter')
console.log(recipe) // { name: 'Risotto', ingredients: ['rice', 'stock'] }
console.log(recipe2) // { name: 'Risotto', ingredients: ['rice', 'stock', 'onions', 'butter'] }
console.log(recipe === recipe2) // false
```

Now our `addIngredients` function makes a copy of the recipe object, before updating the ingredients array. Now that we have a copy of the object, we can update it without affecting the original object. It is important to note that the spread operator only copies **one level deep**. If your data structure has objects nested multiple layers deep, the lower levels will still be referencing the original data structure.

Many of the array methods mutate the existing array rather than return a new array. Helper utilities which copy the array before mutating them assist with maintaining value immutability. Array methods which mutate the array instance directly include:

- `pop`
- `push`
- `reverse`
- `shift`
- `sort`
- `splice`
- `unshift`
- Directly setting a value, such as `arr[0] = 'foo'`

## TLDR

- A side effect occurs when a function impacts the application state outside itself (ie outputting to the DOM, updating a global variable, etc)
- A side cause occurs when a function references data outside its scope to complete it's operation. This causes the function to output different results if the outer data changes
- Both side effects and side causes make a function impure. Any function which also calls an impure function becomes impure.
- Pure functions do not have side effects or side causes. They are preferred for predictability, testing, and reasoning through an application.
- Favor value immutability. Be aware that arrays and objects in function arguments are by reference not value. Make a new copy of the data structure to avoid mutating the reference.

Managing side effects and the purity of functions is an important part of functional programming. They allow for more robust and testable code. Next week we will be diving into functors and monads.
