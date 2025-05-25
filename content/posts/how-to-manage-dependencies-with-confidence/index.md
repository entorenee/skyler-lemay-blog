---
title: 'How to Manage Dependencies with Confidence'
slug: 'how-to-manage-dependencies-with-confidence'
draft: false
publishDate: '2019-02-25'
categories: ['Web Development']
tags: ["tooling","npm"]
---
![How to Manage Dependencies with Confidence](images/2019-02-balanced-rocks.jpg#center)

Managing dependencies is a core part of maintaining a project long term. Projects run the [risk of decay](https://en.wikipedia.org/wiki/Software_rot) if not maintained. The evolution of the environment around them can also introduce decay. Dependency management can be an intimidating and error prone process, if not approached with a plan. About a year ago, I went to update the dependencies for a full stack JavaScript application for the first time in over four months. Not knowing any better at the time, I ran `npm update` and updated all the server and client dependencies in one fell swoop. Looking back I shudder even thinking of that and what happened next. It took two to three hours to get beyond the red React error screen. It was another hour or two until I felt comfortable that everything was operational.

There are many things that went wrong with that experience. The obviouse one was upgrading with no concept of breaking changes. We were also using an early beta release of one dependency and did not have an automated test suite. Upgrading dependencies does not have to be this way. I have settled on three core concepts to help better manage your project’s dependencies with greater confidence.

## Check dependencies regularly

Maintaining dependencies on a regular basis makes the corresponding updates manageable. If you update your dependencies often, there will be less packages to update with smaller version bumps. In my experience, this results in a reduced sense of analysis paralysis. I know delaying the process makes it a bigger problem later, but the pile of dependencies and versions to review is daunting. Procrastination becomes easier when it is not a consistent development process.

Reducing the interval between dependency updates results in smaller version bumps. This enables you to better approach the changelogs for a particular dependency. More approachable changelogs help to identify potential and outright breaking changes. Updating less often requires keeping more in mental overhead. This convolutes the process and makes it more prone to error.

There are a couple of processes that I have found helpful to maintain a consistent rhythm to updating dependencies. First, you can set a reminder to create a dependency management branch at a set interval, such as every two weeks. Find a balance where the updates are not overwhelming, but there are also enough for it to be worth your time. The benefit of this approach is branch scope remains pure to updating dependencies. However, it can be easy to forget this process unless you have mechanism in place to remind you. Another approach is to check and update dependencies before each PR. This allows for a consistent schedule and mental mnemonic: you always check and update dependencies before opening the PR. This comes with the cost of mixing dependency updates with other features or bug fixes. You should also check that dependency updates don't interfere with the original purpose of the branch.

My general approach is to update minor version bumps of dependencies before PRs. Update major version bumps or more complex dependencies in their own isolated branch.

## Use better tools to update your dependencies

How you go about updating your dependencies can have a vast difference in the overall experience. Both Yarn and NPM offer command lines to update all or specific packages: `yarn upgrade [package name]` and `npm update [package name]` respectively. Want to update past the semver setting in your package.json? Add `@latest` to the end of the package name. The problem with both of these approaches is that they don't identify the version you are currently on and what you are updating to.

An alternative approach is to use interactive updating tools. These tools allow you to see which version of a dependency you are on, according to the lock file, and what the current version of the package is. You can then select which packages you want to update. Yarn ships with this out of the box. You can run `yarn upgrade-interactive` to launch the upgrade process in interactive mode. This will show all your dependencies which need updates, the current version installed, and the current version that npm can provide. By default this will respect your semver ranges and not show packages outside of semver. To also display those packages run `yarn upgrade-interactive --latest`.

As of publishing, NPM does not ship with this functionality out of the box. I recommend downloading the package [npm-check-updates](https://github.com/tjunnone/npm-check-updates) (NCU) to fulfill this need. It is also one of the few npm packages that I install as a global binary. NCU shares some functionality of yarn’s tooling with some notable differences. By default it will only upgrade packages outside of your semver range. Adding the `-a` flag to the command will ignore semver range. It also relies on adding filters, exceptions, or naming packages to have granular control over which packages are updated. Lastly, it only updates your package.json and requires running `npm install` to update the lock file. In my option, NCU is a better tool than the native npm commands, but neither come close to Yarn’s workflow.

Interactive dependency updates allow for easier selection of dependencies and save annoying typo errors. Scoping which packages you are updating in each round allow better checks for breaking changes. Upon discovering a breaking change, it also helps to identify which package was the source of the issue.

## Have a system to check against breaking changes

Updating dependencies can introducing breaking changes, even within semver. However, leaving dependencies to stagnate introduces potential bit rot which can also introduce breaking changes. Creating a system which runs checks against the code base after updates helps mitigate some of these risks and concerns.

I recommend that you group your dependency updates by area of concern. There may distinctive groupings such as tooling dependencies and build dependencies. When upgrading dependencies, update related dependencies as a group. For example, update the linting dependencies together. These dependencies only affect the linting process. After updating those dependencies run your lint script. If there are no errors or warnings the upgrade was successful. If there are errors or warnings, address those if possible. If everything is successful, commit that group of changes. This enables the option to checkout changes if another upgrade is unsuccessful. If the changes are unsuccessful, investigate further and choose the appropriate course of action from there. The process of selective updates provides greater freedom to revert changes with less impact.

The updated dependency guides the scripts you run to check whether the it was successful. If it is a tooling dependency, check that particular piece of tooling. If the dependency touches the build process or the live application some extra steps may need to take place. I use [Webpack](https://webpack.js.org/) for the asset bundling of my applications. If there is a project which affects the build tooling process within Webpack itself run the develop and build script to check for errors within the build process. The build and develop scripts generally run through different processes. There may be errors unique to each environment. If the dependency updates a specific part of the application, you may want to do a quick check that those areas are continuing to behave as expected. With all dependency updates run your test script and ensure that all tests are passing before continuing forward.

## Consider automating the process

The next evolution of dependency management is to use tools to automate some of the tedium. Apps like [Dependabot](https://dependabot.com/) and [Greenkeeper](https://greenkeeper.io/) connect to a repository and watch dependencies for updates. When a newer version is available, a PR is automatically opened against the repository. The PR will often insert the details of the changelog into the PR. Continuous integration (CI) checks will also run against the updated dependency. These checks can automate many of the tasks outlined above. Both Dependabot and Greenkeeper are free to use with public repositories. At the time of publishing Greenkeeper charges $15 for a personal private repo per year. Dependabot is free for all repos on personal accounts. The major benefits of these tools are automating the dependency check, and bringing the release notes for the new versions to one central location.

Dependabot and Greenkeeper help automate the process of checking for dependencies, but they don't solve the various checks to see if the dependency is breaking anything by themselves. CI services step in to fill that particular gap. Two popular services which are both free for public repositories are [Travis](https://travis-ci.org/) and [CircleCI](https://circleci.com/). These services can run a set of scripts such as: linting, testing, and building. If there are any errors with the defined scripts the build will fail and be noted in the GitHub check. This alerts you that there is a problem to explore further with that given dependency. CI servers have many use cases and do not require much configuration to get a basic instance set up.

## Recommended practices

In summary, you will experience reduced friction in managing dependencies if you engage in the process regularly and have a system for doing so. Find the methods, tooling, and frequency that works best for you and the project that you are maintaining. Some important concepts to keep in mind are:

- Maintain your dependencies with a level of frequency that the package count and version gap feels manageable
- Update your dependencies by areas of concern
- Test, lint, and run build checks after updating dependencies to look for potential breakage. If a dependency touches a specific piece of functionality conduct some quick smoke tests
- Use automation tools such as dependency checkers and CI to automate and optimize the process
