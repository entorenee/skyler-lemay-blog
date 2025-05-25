---
title: 'Better Dependency Management Using Renovate'
slug: 'better-dependency-management-using-renovate'
draft: false
publishDate: '2019-11-18'
categories: ['Technical']
tags: ["tooling","npm","productivity","code-quality","JavaScript"]
---
![Better Dependency Management Using Renovate](images/shipping-crates-stacked.jpg#center)

> I have moved most of my open source projects to Renovate, and found I simultaneously spend less time focusing on dependency updates and have more current dependencies.

Over the past few months I have been moving most of my projects to [Renovate](https://renovatebot.com/) for managing dependencies. From my experience, Renovate offers several key benefits over other solutions such as Greenkeeper and Dependabot. This blog post will focus on what Renovate is and what differentiates it from other dependency management solutions. For a higher level overview on dependency management, I recommend checking out [how to manage dependencies with confidence](/blog/2019/02/25/how-to-manage-dependencies-with-confidence).

## What is Renovate

Renovate is a GitHub, or GitLab, application that monitors dependency updates for a given repository and opens Pull Requests when new versions are available. While I have used them for JavaScript dependency management, Renovate also supports the following languages and package managers: Bazel, Docker, Golang, Java, Nuget, PHP, Python, and Ruby. For JavaScript applications, Renovate works for projects managed with npm or yarn.

Renovate uses a configuration file, `renovate.json`, that lives at the root of each repository to handle how Renovate manages the dependencies for that project. These files behave similar to an `.eslintrc` file, providing multiple presets and reasonable defaults for various use cases using the `extends` property. A benefit of this approach is that dependency management approaches can be replicated across projects by copying the configuration file. Renovate itself is un-opinionated, giving developers granular control. Below is the `renovate.json` from one of my projects.

```json
{
  "extends": ["config:base"],
  "baseBranches": ["develop"],
  "bumpVersion": null,
  "packageRules": [
    {
      "depTypeList": ["devDependencies"],
      "updateTypes": ["minor"],
      "automerge": true
    }
  ],
  "prHourlyLimit": 5,
  "prConcurrentLimit": 10,
  "rangeStrategy": "bump"
}
```

Most of the configuration comes by extending the base config from Renovate. Out of the box, Renovate will PR against your *default* branch which is generally master. Setting the `baseBranches` key allows you to override this behavior and PR against different branches. This configuration also opts to update the package.json version in addition to the package-lock.

## What makes Renovate different

A key differentiating factor that Renovate provides is the ability for fine-grained control of automerging dependencies based on rules set in the config. Other dependency management tools have required a binary decision to enable or disable across the board. In the configuration above, inside the `packageRules` array I have specified that all devDependencies which are minor or patch updates can be automerged if the CI pipeline succeeds. Automerging is disabled by default, but can be a useful tool for keeping lower risk dependencies updated with reduced friction. Renovate also allows matching or ignoring certain packages from automerge using regular expressions, if you require tighter control.

Another benefit of Renovate, is the grouping of monorepo updates in a single PR. Other solutions I have used will open a PR for each dependency. This causes problems with the proliferation of monorepos such as Babel and React. In most cases, these dependencies need to be updated at the same time or they can break the application. For example, I would not want to have my application using React 16.8.0 and React DOM 16.9.0. However, other tools can put your application in this state which can be a problem for Continuous Deployment scenarios. Renovate takes a different approach. When a monorepo publishes multiple package updates, Renovate opens a single PR for all of the updates. This means that all of your React updates or Babel updates live in one PR.

Keeping dependencies up to date can be a chore, especially in a fast moving ecosystem like JavaScript. Renovate reduces this friction by automating this process through fine-tuned configuration. I have moved most of my open source projects to Renovate, and found I simultaneously spend less time focusing on dependency updates and have more current dependencies. While I find the automerging of select dependencies beneficial, the grouping of updates for monorepo packages is a huge win in itself. If you dive into Renovate and have questions about your specific configuration, they also have a [repository](https://github.com/renovatebot/config-help) that you can open an issue against for additional support.
