---
title: '8 New ESLint Rules - Jest'
slug: '8-new-eslint-rules-jest'
draft: false
publishDate: '2019-09-09'
category: 'Web Development'
tags: ["Linting","Tooling","Testing"]
---
![8 New ESLint Rules - Jest](images/markus-spiske-stacked-stones.jpg#center)

Maintaining an ESLint config has several benefits, a significant one being seeing new rules as they become available. ESLint [shapes the way we use JavaScript](/blog/2019/05/23/shaping-javascript-usage-with-eslint), and now TypeScript too. As I prepared for the latest release of my own ESLint config, I became aware of several new and helpful rules for testing with Jest. In this post, I'll dive into what some of these new rules are and some considerations for why they aren't added to the `recommended` options.

## The interesting balance of ESLint semver

ESLint rules are an interesting interplay with semantic versioning or semver. Adding a new rule as an option is considered a feature and warrants bumping the package a minor version. However, enabling the rule as an error can cause new lint errors. This is considered a breaking change and requires bumping a major version. I imagine that this is one of the significant reasons that larger ESLint configs enable new rules on a less frequent basis. For example, almost a year passed between major versions of the AirBnB ESLint style guide. Reading through the ruleset before the latest major version uncovered many TODOS for rules to enable.

The recommended settings that an ESLint plugin provides, are also held to such constraints. While these rules are available now, they won't be available in the recommended configuration until the next major version. There is also the possibility that the library authors may choose to not enable them in the recommended config if the rule serves an edge case. If you discover a rule you think would be beneficial, please make sure to add it to your `eslintrc` specifically.

![List of rules that the Jest ESLint plugin enables within the recommended configuration](//images.ctfassets.net/024qyvhyq0tv/biJ8vnA9C00ewpjAsBnk6/a2aafcbc4250b57066499bad31cb58a2/eslint-plugin-jest-recommended.jpg)

## New Jest rules

The Jest ESLint plugin has recently come out with 8 new ESLint rules. Below is a quick explanation of each rule, and how I configured them in my ESLint config.

- [No commented out tests](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-commented-out-tests.md): The Jest plugin already had a rule for checking against [disabled tests](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-disabled-tests.md). However, that rule does not catch if the test has been commented out. This new rule captures this use case as long as the author does not create aliases for Jest globals, ie `const testSkip = test.skip`. Similar to disabled tests, I have this rule set to `warn`.
- [No duplicate hooks](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-duplicate-hooks.md): This rule calls out having duplicate instances of a given hook (`beforeEach`, `afterEach`, `beforeAll`, `afterAll`) in a given describe block. Duplicating a given hook instance is likely developer error from missing an existing hook. I have this rule set to `error`.
- [No if](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-if.md): This rule watches for if statements or ternaries within a given test. The existence of this branching logic within a test can be indicative that a test is too complex and covering too much. It is best to break these into separate tests, and keep each test case clear. I have this rule set to `error`.
- [No try expect](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-try-expect.md): Nesting tests inside of a try catch block and asserting on the error state can pose some problems where the `catch` block is silently skipped. This reduces testing confidence. A more robust means of handling this scenario is using the `toThrow` method within Jest. This asserts that an exception was thrown and that the error's contents match the expected output. This rule flags usage of `expect` within a try catch block. I have this rule set to `error`.
- [No standalone expect](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-standalone-expect.md): `expect` assertions will only run if they are inside a `test` or `it` block. They will not run if they are placed inside a `describe` block but outside of the `test/if` blocks. Placing them in these locations is likely developer error and bound to cause confusion. I have this rule set to `error`.
- [No export](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-export.md): In my opinion, test files are designed to import the various pieces they need to run the code under test and make assertions. Following this mindset, it does not make sense for a test file to export anything. This rule tracks if anything is exported from a test file. I have this rule set to `error`.
- [No expect resolves](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-expect-resolves.md): This rule is tailored for testing promise resolved values. It favors using `expect(await promise)` over `await expect(promise).resolves`. The rule is cited as increasing readability. I personally haven't experienced these testing patterns and currently have the rule set to `off`.
- [Require top level describe](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/require-top-level-describe.md): This rule favors nesting all tests and hooks within a `describe` block. It will fail if any hooks or tests are written outside a describe block. Personally, I find a lot of value in grouping particular tests within a suite via `describe`. I estimate that I use it in 90% of my test suites. However, this rule seems overly prescriptive outside a given team or project's considerations. I have this rule set to `off`.

## Dive into your plugins

ESLint configs, plugins, and recommended settings are a great place to get started with a base level of configuration. As noted above, the recommended setting may exclude many rules. It can be helpful to review rules which are not enabled by default to see if they may benefit a project. Taking these steps can increase the automated checks on a codebase and does not require reading the entire ESLint ruleset.
