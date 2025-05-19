---
title: 'Shaping JavaScript Usage with ESLint'
slug: 'shaping-javascript-usage-with-eslint'
draft: false
publishDate: '2019-05-23'
category: 'Web Development'
tags: ["Tooling","Linting","Accessibility"]
---
![Shaping JavaScript Usage with ESLint](images/shaping-pottery.jpg#center)

I have used ESLint for a long time, often extending the recommended rules from various plugins. I only read a rule’s documentation if I wasn’t sure why it was being flagged in the linter. Last month I read through and manually set 381 ESLint rules, reading the accompanying docs for each rule. I discovered that ESLint is more than enforcing community guidelines on code quality. It also helps to shape use of the language as a whole and through project specific rule usage.

## Greater control for team objectives

There are a number of rules the recommended configurations of ESLint or various plugins do not enable by default. These rules serve specific needs of a given project. They can be enabled and configured on a per project basis and provide feedback for shifting directions within the project.

One example rule is the [no-restricted-properties](https://eslint.org/docs/rules/no-restricted-properties) rule. When enabled, this allows blocking the use of specific properties on an object. You can also provide a custom error message. This can be beneficial to deprecate properties or methods from internal APIs or from a common utility package such as Lodash. For example, a codebase may use Lodash's extend function liberally and desire to move towards `Object.assign`. Rather than rely on checking for this in code reviews, the no-restricted properties rule can warn or error against it's usage.

    {
        "rules": {
            "no-restricted-properties": ["error", {
                "object": "_",
                "property": "extend",
    						"message": "Please use Object.assign instead"
            }]
        }
    }

The rule behaves differently depending on which fields are provided. Omitting the message field will provide a general message for the error. Omitting the property key will disallow the use of any properties on the supplied object. Omitting the object key will disallow the given property on any objects.

The [no-restricted-modules](https://eslint.org/docs/rules/no-restricted-modules) and [no-restricted-imports](https://eslint.org/docs/rules/no-restricted-imports) rules provide the ability to flag or disallow using certain modules via `require` and `import` respectively. Due to the difference in how CommonJS and ECMAScript modules behave, each rule governs the import syntax for one module type. This can assist migrating from one dependency to another, or if a given project uses a different dependency than the team generally uses. Similar to `no-restricted-rules` these rules can accept optional messages to display. The `no-restricted-imports` rule may also disallow certain named exports from a module, which could be utilized if a given approach is being internally or externally deprecated.

## Refine testing practices

The approach taken to testing JavaScript can vary substantially depending on the team's testing preferences and what gives them confidence. One approach that can be highly contested is whether to use the Jest Snapshot feature. If snapshots are used, should any limits be placed on the,. The [Jest ESLint plugin](https://github.com/jest-community/eslint-plugin-jest) provides several ways to configure how Jest is used. I wrote previously on how to use the `no-large-snapshots` rule to [manage the max length of your snapshots](/blog/2019/03/18/how-to-manage-snapshots-with-eslint). Another rule to manage snapshots is [prefer-inline-snapshots](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/prefer-inline-snapshots.md). When enabled this will require you to use Jest's `toMatchInlineSnapshot()` API over `toMatchSnapshot()`. This writes the result of the snapshot inside the test source file rather than an external `.snap` file. This can encourage the use of focused and smaller snapshots to maintain readability in the test file.

The Jest ESLint plugin has relatively few rules that are enabled with the recommended configuration. There are many other valuable rules which can improve the developer experience when writing tests. Some highlights include:

- [consistent-test-it](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/consistent-test-it.md): Enforce a consistent use of `test` or `it` for your test assertions.
- [no-disabled-tests](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-disabled-tests.md): Flag if any tests are skipped. While it can be helpful to skip tests during debugging, this is likely something you don't want committed.
- [no-focused-tests](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-focused-tests.md): Flag if any tests are focused. Committing a test suite with a focused test is often not intended and a result of debugging or writing new tests. Committing focused tests reduces the effectiveness and coverage of your tests.
- [prefer-called-with](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/prefer-called-with.md): This rule requires more specific assertions on the arguments a mock function is called with. This gives greater confidence that the function is receiving the arguments as anticipated.

## Shaping the landscape of JavaScript

Another interesting facet of ESLint is the ability to shape the landscape of JavaScript's usage as the language evolves. As newer features of the language or tooling are created, rules can be created to encourage developers to migrate their code base. Some rules focus on stylistic preference, where others help improve the readability and maintainability of the code.

The [Yoda](https://eslint.org/docs/rules/yoda) rule is one of the more interesting ESLint rules. This rule allows or disallows formatting conditionals where the value of the condition comes first.

    if ('Yoda' === name) {
    	// Do something
    }

This practice existed to circumvent accidental assignment via `name = 'Yoda'`. Since JavaScript does not allow assigning to a literal value, `'Yoda' = name` would error out if an assignment operation was accidentally used. However, the increase in tooling, including ESLint's [no-cond-assign](https://eslint.org/docs/rules/no-cond-assign) rule, catches assignment in conditional blocks. This eliminates the need for Yoda statements and allows for more readable code.

ESLint also provides rules to govern how variables are declared for code bases which are utilizing ES6 syntax.The [prefer-const](https://eslint.org/docs/rules/prefer-const) rule will flag `let` declarations which are not re-assigned and recommend changing them to `const` to indicate that the variable is not re-assigned. This can also be combined with the [no-var](https://eslint.org/docs/rules/no-var) rule to disallow the use of `var` declarations in favor of the block scoped `let` and `const`.

The object spread operator is part of the official spec as of ES2018. In order to support it's usage, ESLint introduced the [prefer-object-spread](https://eslint.org/docs/rules/prefer-object-spread) rule in version 5. This rule disallows using an object literal as the first argument in a call to `Object.assign` preferring the use of the spread operator. It will also error if an object literal is the only argument of the function. In this case, there is no reason to use `Object.assign`.

## Bringing accessibility to the forefront

The current state of accessibility across the web is abysmal. According to [HTTP Archive](https://beta.httparchive.org/reports/accessibility) the median accessibility score in Lighthouse is 64%. Only 46.8% of images have alt text and 8.6% of form elements have associated control. These scores represent an overall lack of making websites accessible to everyone. This has resulted in increasing legal repercussions. In the US, web accessibility lawsuits [increased 181%](https://blog.usablenet.com/2018-ada-web-accessibility-lawsuit-recap-report) from 2017 to 2018.

The [JSX a11y plugin](https://github.com/evcohen/eslint-plugin-jsx-a11y) brings this issue to the forefront in React development. This plugin helps to identify accessibility misses through ESLint. As an added benefit, the rule documentation often breaks down the accessibility concerns, and the problems that the fix solves. As of publishing, there are 38 available rules in this plugin including: 

- Links have inner content.
- Form inputs have associated labels with corresponding control.
- Image has alt text. Additionally it checks that the alt text does not contain the word 'image' which is redundant for screen readers.
- Click events have corresponding key handlers.
- Headings have content.

The ability to use ESLint to highlight accessibility oversights is a great addition to the tooling. While static analysis does help catch accessibility concerns, it does not capture everything. A common practice may be to use an image primitive which accepts a prop for the alt text. This plugin will not catch if that prop is missing. For internal component usage this can be enforced with prop-types or static typing. However, if a component is receiving props from an API, the result still needs to be validated through manual or automated testing on the rendered DOM. Greater accessibility confidence comes with manual testing using accessibility tools.

## TLDR

In summary, ESLint is an excellent contribution to the vibrancy of the JavaScript ecosystem. Beyond general best practices, it allows for:

- Project specific rules to catch undesired properties, imports, and methods.
- Encouraging the progressive implementation of new JavaScript features as they entire the ECMAScript standard.
- Highlighting accessibility concerns closest to the code, in the text editor.
- Other shareable configuration, custom rules, and plugins that are desired for a team.

The object structure of ESLint configurations also lends them to easy extension and overriding of configuration. The `extends` array in the configuration is simply passing in other ESLint config objects. This allows for the componentization and creation of shareable ESLint configs by individuals and organizations. These can then be published to NPM for reduced tooling friction across projects.
