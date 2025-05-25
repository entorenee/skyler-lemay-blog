---
title: 'TypeScript Utility Types Part 3: Extract, Exclude, and NonNullable'
slug: 'typescript-utility-types-part-3-extract-exclude-and-nonnullable'
draft: false
publishDate: '2020-05-25'
categories: ['Technical']
tags: ["TypeScript","TypeScript-generics"]
series: ["Diving into TypeScript Generics"]
---
![TypeScript Utility Types Part 3: Extract, Exclude, and NonNullable](images/intersecting-types.jpg#center)

TypeScript utility types provide built in type composition tools to generate new types. They capitalize on TypeScript generic types to enable this functionality. In the third part of this series, we will be covering the `Extract`, `Exclude`, and `NonNullable` utilities. For more coverage on other utility types, check out the previous two posts in the series.

- [TypeScript Utility Types Part 1: Partial, Pick, and Omit](/blog/2020/04/27/typescript-utility-types-part-1-partial-pick-and-omit)
- [TypeScript Utility Types Part 2: Record, Readonly, & Required](/blog/2020/05/04/typescript-utility-types-part-2-record-readonly-and-required)

## Extract

`Extract<T, U>`. is a utility for pulling out values that are shared between the two type arguments it receives. This can be useful for refining types for other implementations, or to remove types that another implementation may not accept.

```tsx
interface UserBase {
  email: string
  image: string | null
  username: string
}

interface UserProfile {
  id: string
  email: string
  image: string | null
  isAdmin: boolean
  username: string
  reviews: string[]
}

/*
 * If we want to find the shared keys between these interfaces, we can combine
 * keyof with Extract. keyof will give us a union string of all the keys, and
 * Extract will return the shared values.
 */

type SharedUserKeys = Extract<keyof UserBase, keyof UserProfile>
// 'email' | 'image' | 'username'
```

By using `Extract` on the two user interfaces, we have a type of the three shared properties. This type can then be used to check that a given argument for a function is one of these keys and not one that is either unknown or not shared. If we wanted to transform this back into an object we can combine `Extract` with our own custom type.

```tsx
interface UserBase {
  email: string
  image: string | null
  username: string
}

interface UserProfile {
  id: string
  email: string
  image: string | null
  isAdmin: boolean
  username: string
  reviews: string[]
}

/*
 * If we want to find the shared keys between these interfaces, we can combine
 * keyof with Extract. keyof will give us a union string of all the keys, and
 * Extract will return the shared values.
 */

type SharedUserKeys = Extract<keyof UserBase, keyof UserProfile>
// 'email' | 'image' | 'username'

/*
 * Convert our union string back into an object type with the shared
 * properties and their corresponding value types.
 */
type SharedUserData = {
  [K in SharedUserKeys]: UserProfile[K]
}

const user1: SharedUserData = {
  email: 'test@example.com',
  image: null,
  username: 'sampleuser',
}

/*
 * Here we can eliminate the SharedUserKeys intermediary step, and return
 * a new object type with the shared properties between two other types
 */
type IntersectingTypes<T, U> = {
  [K in Extract<keyof T, keyof U>]: T[K]
}

const user2: IntersectingTypes<UserBase, UserProfile> = {
  email: 'test@example.com',
  image: null,
  username: 'sampleuser',
}
```

In both the `SharedUserData` and `IntersectingTypes` types, we utilize the `[K in OTHER_TYPE]` pattern. This allows us to iterate over a union type, in this case `'email' | 'image' | 'username'` and set the key name as the current iterator. In both cases we set the value for each key by referencing the parent type. This works similar to referencing a value on a JavaScript object with a dynamic key. The `IntersectingTypes` implementation works in the same way, but inlines the usage of `Extract` that we previously had in a separately declared type. Here we also create a type with our own generic types, `T` and `U`, that will represent our base objects.

## Exclude

`Exclude<T,U>` works similarly to `Extract` but performs the inverse operation. It will return all of the values present in `T` that are not present in `U`. In our previous example, we can use this to find all of the properties that are unique to `UserProfile`.

```tsx
interface UserBase {
  email: string
  image: string | null
  username: string
}

interface UserProfile {
  id: string
  email: string
  image: string | null
  isAdmin: boolean
  username: string
  reviews: string[]
}

type ProfileSpecificKeys = Exclude<keyof UserProfile, keyof UserBase>
// 'id' | 'isAdmin' | 'reviews'

type ExcludedTypes<T, U> = {
  [K in Exclude<keyof T, keyof U>]: T[K]
}

const user: ExcludedTypes<UserProfile, UserBase> = {
  id: '1234',
  isAdmin: false,
  reviews: [],
}
```

## NonNullable

`NonNullable<T>` will take a type and remove `null` and `undefined` from the allowed types. This can be useful for instances where a type may allow for nullable values farther up a chain, but later functions have been guarded and cannot be called with null. For example an application may have the concept of a nullable user at the top level of the application. Here we should be guarding against null values. We may have several internal functions that always expect a user to be present. We could use a higher order function to address the null guard before calling these functions. In that case, we no longer need the null branch for these internal functions and can remove them with `NonNullable`.

```tsx
interface UserBase {
  email: string
  image: string | null
  username: string
}

// NullableUserBase can be a UserBase or null
type NullableUserBase = UserBase | null

const missingUser: NullableUserBase = null

// This will throw a compilation error as null has been removed
const requiredUser: NonNullable<NullableUserBase> = null
```

It is important to note that this utility is not recursive. In the case of our user example, `image` can still be null. If we wanted to change the type of `image` to disallow null, we would need to extend the base type and override specific properties.

```tsx
interface UserBase {
  email: string
  image: string | null
  username: string
}

interface RequiredImage extends UserBase {
  image: NonNullable<UserBase['image']>
}

const user: RequiredImage = {
  email: 'hello@example.com',
  image: 'my/image/url',
  username: 'sampleuser',
}
```

## TLDR

Today we covered three new TypeScript utilities:

- Use `Extract` when we want to pull out a set of given types from a parent type.
- Use `Exclude` when we want to eliminate a set of given types from a parent type.
- Use `NonNullable` when we want to remove `null` and `undefined` from a a type. This is not a recursive operation.

As with other utility types we have covered in previous posts, these can help us to keep reuse and shape existing type definitions throughout our application. What TypeScript utilities have you found most valuable? What questions do you have about using TypeScript utilities or generics?
