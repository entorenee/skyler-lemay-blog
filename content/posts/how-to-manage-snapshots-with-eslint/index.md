---
title: 'How to Manage Snapshots with ESLint'
slug: 'how-to-manage-snapshots-with-eslint'
draft: false
publishDate: '2019-03-18'
category: 'Web Development'
tags: ["Testing","Tooling","Linting","Jest","Code Quality","Best Practices"]
---
![How to Manage Snapshots with ESLint](images/paul-skorupskas-snapshot.jpg#center)

> Snapshots are still an assertion, but can become broad ones. Favor specific assertions where workable.

Jest Snapshots can be a valuable utility for monitoring code changes for UI components. They can also become a scourge if they become too large. The line between the two isn't always clear. Snapshots don't offer a clear mechanism to determining how large they are. This makes it easy to create large snapshots that are hard to diff.

The likelihood of a thorough review on a snapshot diff decreases in relation to the size of the snapshot. I have both observed and committed broken snapshot updates into repositories as part of a branch. The danger lies in making intentional changes to a particular feature and updating the snapshot without checking for other breakages. If the snapshot diff is large, it will likely not receive as thorough a review. Snapshots are only as good as the level of review they receive. If you update and commit a broken snapshot it is more difficult to use that as a method for identifying issues.

## Solutions to the growing snapshot

One tool that can help combat growing snapshots is the Jest ESLint plugin for [large snapshots](https://github.com/jest-community/eslint-plugin-jest/blob/master/docs/rules/no-large-snapshots.md). This rule can set a maximum length for a snapshot before the rule will warn or error out. This brings awareness to the size of a snapshot. If a snapshot becomes too large, it is harder to check for breaking changes. Writing more pointed assertions may better serve the testing needs. The rule defaults to 50 lines. Depending on the test use cases this may be unrealistic. For React development, something closer to 200-300 lines is more realistic.

There are other means of addressing poor snapshot usage in tests. These additional measures, combined with the ESLint rule, can help mitigate some risks of blind snapshot updates.

- Ask yourself if there are more specific things about the component that you care to check. Writing more specific tests may give greater confidence in testing the feature. This may result in eliminating or reducing the need of a snapshot. Remember that snapshots are still an assertion, but can become broad ones. Favor specific assertions where workable.
- If there are snapshot changes, make sure to review them before updating them and at the PR stage. The best time to catch a broken snapshot is before it gets merged into the core branch.
- If there are many snapshots to update, use the interactive update mode in Jest. You can enter this by pressing `i` when in watch mode. Jest will display one snapshot at a time. You can update the current snapshot by pressing `u`, or press `s` to skip it. This enables more granular control over updating snapshots.
