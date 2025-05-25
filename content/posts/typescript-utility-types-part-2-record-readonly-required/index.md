---
title: 'TypeScript Utility Types Part 2: Record, Readonly, & Required'
slug: 'typescript-utility-types-part-2-record-readonly-required'
draft: false
publishDate: '2020-05-04'
categories: ['Web Development']
tags: ["typescript","typescript-generics"]
series: ["Diving into TypeScript Generics"]
---
![TypeScript Utility Types Part 2: Record, Readonly, & Required](images/reflective-architecture-perspective.jpg#center)

TypeScript utility types provide built in type composition tools to generate new types. They capitalize on TypeScript generic types to enable this functionality. Previously we talked about the `Partial`, `Pick`, and `Omit` types as well as utility types as a concept in [part 1 of this series](/blog/2020/04/27/typescript-utility-types-part-1-partial-pick-and-omit). In this post we will dive into three more of the utility types provided by TypeScript: `Record`, `Readonly`, and `Required`.

## Record

`Record<K, T>` is the first utility type we have covered that takes two generic types. This utility generates a type with the properties present in `K` with the corresponding values of type `T`. This utility can be helpful in create type objects from union strings, or even generic polymorphic types.

```typescript
interface Dropdown {
  label: string
  value: string
}

type FilterCategories = 'region' | 'pricePoint' | 'sortBy'

/*
 * The corresponding type will utilize the union string as the keys
 * with an array of Dropdowns as the value type.
 * {
 *   region: Dropdown[]
 *   pricePoint: Dropdown[]
 *   sortBy: Dropdown[]
 * }
 *
 * Note that this is the primary way to convert a union string to keys of a type.
 * The following approach would throw a compilation error.
 * type FilterGroups = {
 *   [key: keyof FilterCategories]: Dropdown[]
 * }
 */

type FilterGroups = Record<FilterCategories, Dropdown[]>

/*
 * We can also create types with an unknown number of keys, but whose
 * values must be of a specified type. The following would allow this to be
 * a valid implementation of the type.
 *
 * {
 *   region: Dropdown[]
 *   pricePoint: Dropdown[]
 *   color: Dropdown[]
 * }
 */

type BroadFilters = Record<string, Dropdown[]>
```

`Record` is a very flexible utility type and can eliminate a lot of duplication if you already have keys stored in a union string and want to convert them to properties on a type. It is also incredibly helpful when all of the keys on a type may not be known in advance, such as more generic objects.

## Readonly

`Readonly<T>` takes the type it receives and marks all of its properties as read only. This will cause compilation errors to be thrown if properties of the returned type are reassigned. 

```typescript
interface Todo {
  isCompleted: boolean
  text: string
}

interface State {
  todos: Readonly<Todo>[]
}

const sampleTodos: Readonly<State> = {
  todos: [
    { isCompleted: false, text: 'Learn more about TypeScript utilities' },
    { isCompleted: true, text: 'Post Part 1 of TypeScript series' },
  ],
}

/*
 * The following will throw a compilation error, because we marked the Todos
 * as read only.
 */

sampleTodos.todos[0].isCompleted = true

/*
 * In order to modify an existing todo we need to create a copy of it with
 * the desired modifications
 */

const newTodos = {
  todos: [
    {...sampleTodos.todos[0], isCompleted: true },
    ...sampleTodos.todos.slice(1)
  ]
}
```

This utility can be beneficial for representing the immutability of a frozen object. It can also enforce immutable handling of data structures for functional programming or other programming patterns such as handling state in Redux.

## Required

`Required<T>` has the inverse effect of `Partial` in that it makes all properties of the supplied type required. This can be used to make a looser type more strict. Also similar to `Partial` is that this operation is all in, and does not provide leeway to allow certain properties to remain optional.

```typescript
interface ChartData {
  overrides?: {
    dataLabels?: {
      enabled: boolean
    }
  }
  title: string
  type?: 'bar' | 'line' | 'pie'
  data: number[]
}

/*
 * The following will require all the properties to be present in order
 * to pass compilation. Note that the Required call is not recursive
 * for nested objects and the following structure of overrides will
 * still compile.
 */

type RequiredChartData = Required<ChartData>

const temp: RequiredChartData = {
  overrides: {},
  title: 'My first chart',
  data: [1, 2, 3, 4],
  type: 'bar',
}
```

For selective type overrides we can extend the initial type and then redeclare the properties that we want to make required. By using bracket property syntax like `ChartData['type']` we can also reference the underlying type of the parent interface to capitalize on any upstream changes. One use case I have personally utilized is providing a more specific type for using ApexCharts. Their default Options interface marks most of the fields as optional. In a component implementation I wanted to make the data series required while maintaining the partial nature for the rest of the interface. Using this approach enables these selective refinements.

```typescript
interface ChartData {
  overrides?: {
    dataLabels?: {
      enabled: boolean
    }
  }
  title: string
  type?: 'bar' | 'line' | 'pie'
  data: number[]
}

/*
 * We can optionally require certain properties while leaving others intact
 * by extending the parent type, rather than use Required. Here we will make
 * the type property required, while retaining the optional nature of overrides.
 */

interface RequiredChartData extends ChartData {
  type: ChartData['type']
}

const temp: RequiredChartData = {
  title: 'My first chart',
  data: [1, 2, 3, 4],
  type: 'bar',
}
```

This growing list of utility types encourages the ability to reuse and compose types within our application, allowing for better cascading of types when base values change, if desired. Extending existing types is helpful when parts of a codebase rely on a subset or superset of an existing type. However, we should be cautious when extending unrelated types. In this case the cascading inheritance could create problems and unnecessary complexity.
