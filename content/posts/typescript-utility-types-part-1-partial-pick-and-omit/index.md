---
title: 'TypeScript Utility Types Part 1: Partial, Pick, and Omit'
slug: 'typescript-utility-types-part-1-partial-pick-and-omit'
draft: false
publishDate: '2020-04-27'
categories: ['Technical']
tags: ["TypeScript","TypeScript-generics"]
series: ["Diving into TypeScript Generics"]
---
![TypeScript Utility Types Part 1: Partial, Pick, and Omit](images/compass-with-leather-notebook.jpg#center)

TypeScript provides multiple means of creating, modifying, and extending existing types into new variants using special [utility types](https://www.typescriptlang.org/docs/handbook/utility-types.html). Most of these types utilize generic types under the hood, but a deep understanding of generics is not necessary to utilize them. We can think of utility types as TypeScript functions to return new types. In this post, I'll cover three of the utility types that I use often as well as some examples of how they can be leveraged. These types include: `Partial`, `Pick`, and `Omit`.

If you are not familiar with TypeScript generics, here is a quick overview to better understand the documentation. TypeScript generics are indicated through placing a type variable inside `<>`. An example of this is `Partial<T>`. In this instance, we can think of `Partial` as a TypeScript function that takes an argument `T` and utilizes it in the creation of the value it returns. If only one or two generics are used, it is common to see `T` and `U` referenced. Like parameters, they can be named whatever the author desires. More complex or domain specific implementations will often give these generic types more descriptive names for better documentation of what the type represents.

## Partial

`Partial<T>` is a utility that will take a given type and return a new type where all of it's properties are optional. This is beneficial when you want something that is not constrained by certain properties being required. However, this utility type does not discriminate in forcing some of the properties to remain required. To accomplish this functionality we will reach for `Pick`  or `Omit` instead. I find this utility helpful for areas where I want to provide overrides, such as this testing approach with React Testing Library.

```tsx
import React, { ReactNode } from 'react'
import { render as renderRtl } from '@testing-library/react'

interface BasicButtonProps {
  children: ReactNode
  disabled: boolean
  onClick: () => void
  type: 'button' | 'submit' | 'reset'
}

const render = (overrides: Partial<BasicButtonProps> = {}) => {
  const baseProps = {
    children: 'Hello World',
    disabled: false,
    onClick: jest.fn(),
    type: 'button',
  }
  const opts = { ...baseProps, ...overrides }
  return renderRtl(
    <button type={opts.type} disabled={opts.disabled} onClick={opts.onClick}>
      {opts.children}
    </button>
  )
}
```

Here we have a customized render function that has a base set of props for a component. This allows us to set the happy path for most of our test cases, where we can call `render()` and receive all of our queries from React Testing Library. If there are cases where we want to test other cases, such as when the button is disabled, we can pass in the overrides we care about such as `render({ disabled: true })`. I have found that this eliminates a lot of repetition in component test set up, and provides a declarative way of testing the component with different props.

## Pick

`Pick<T>` enables us to specify a pointed subset of a given type, by declaring which keys of the parent type we want brought into to the returned type. This gives us a *selected* subset of the parent type, and can be useful when we know we want some of the keys from a parent type, but not others. Where `Partial` makes everything optional and does not allow us to enforce the presence of any keys, `Pick` pulls out only the keys we care about, maintaining their optional or required status.

```typescript
interface Card {
  id: string
  isFeatured?: boolean
  name: string
}

interface DataCardProps {
  cardData: Card[]
  handleSelect: (id: string) => void
  titleText: string
}

/*
 * Let's say we have an intermediary component which handles the logic,
 * but still receives the cardData from another source. The return type will be:
 * {
 *   cardData: Card[]
 * }
 */

type CardData = Pick<DataCardProps, 'cardData'>

/*
 * We can also pull multiple keys off a parent type by using a union string
 * as the second argument. The return type below will be:
 * {
 *   cardData: Card[]
 *   titleText: string
 * }
 */

type CardDataWithTitle = Pick<DataCardProps, 'cardData' | 'titleText'>
```

`Pick` is great when we want to inherit specific keys and their types from a parent object. Using this utility enables us to avoid redeclaring those same keys across multiple implementations, resulting in DRYer types overall.

## Omit

`Omit<T>` behaves similarly to `Pick`, but with the inverse effect. We specify the keys of the parent type that we do not want in the returned type. Generally I will reach for the one that requires passing the least number of keys as the second argument. If we want to grab only a few of the keys from a parent type, reach for `Pick`. If there are fewer keys that we want to remove from the parent type, reach for `Omit`. Let's see how it works with the sample `DataCardProps` from before.

```typescript
interface Card {
  id: string
  isFeatured?: boolean
  name: string
}

interface DataCardProps {
  cardData: Card[]
  handleSelect: (id: string) => void
  titleText: string
}

/*
 * Using Pick and Omit below allows both of these implementations to return
 * the exact same type. Depending on what we care about, one may be more
 * ergonomic or clear for the developer and surrounding code.
 */

type CardDataWithPick = Pick<DataCardProps, 'cardData' | 'titleText'>
type CardDataWithOmit = Omit<DataCardProps, 'handleSelect'>
```

In a real world application, there may be substantially more data props that a component is expecting. In that case, it may be more ergonomic to omit the business logic handled by the container component. Again, both `Pick` and `Omit` have inverse behavior of each other. Use whichever makes more sense for the given implementation at hand.

TypeScript utility types augment the flexibility of your existing types and allow the removal of some duplication of types across different implementations. These three utility types are just the beginning of utility types provided out of the box from TypeScript. In future posts, we will examine some of the other utility types at our disposal, and eventually how to create our own.
