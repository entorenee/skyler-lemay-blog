---
title: 'TailwindCSS: From Skeptic to Advocate'
summary: "Why I changed my mind about utility-first CSS after working with Tailwind on three projects."
slug: 'tailwindcss-from-skeptic-to-advocate'
draft: false
publishDate: '2020-05-18'
categories: ['Technical']
tags: ["CSS","tooling","systems-design"]
---
![TailwindCSS: From Skeptic to Advocate](images/abstract-blue-peach-ripples.jpg#center)

> At it's core Tailwind creates extensible yet constrained design systems with reasonable defaults.

[TailwindCSS](https://tailwindcss.com/) is a configurable CSS tool that generates CSS utility classes. These utility classes each set one CSS property, and are combined with other utility classes to generate the styles for a layout. In a utility first CSS approach, elements generally have more classes attached to the DOM in favor of writing bespoke CSS. This is a high level simplification of the tool, but it is an important baseline of understanding before moving forward.

Six months ago, I was skeptical about Tailwind's approach. I have since worked on three projects which  utilized Tailwind, and now advocate for it on future work. In this blog post, we will cover points of skepticism, benefits, and some lessons learned about working with Tailwind.

## Skepticism

The first several times I heard about TailwindCSS, I was pretty skeptical. It didn't understand what problem it was trying to solve and the implementation seemed strange. Tailwind differs in its approach  compared to other common CSS solutions. The following aspects are concerns that I had and have heard expressed by others.

*There's so many class names:* This is one of the first points I raised. Since Tailwind classes only affect one CSS property, more are applied to an element to style it. The argument is that this results in more noise in the code and is harder to reason about when inspecting elements in dev tools.

*I'm pretty decent at CSS (How does this help me)*: While not an expert with CSS, I felt comfortable navigating it and styling interfaces. At first glance, Tailwind seemed to only be a shorthand for writing CSS properties that I already understood. If that's the case, why not write the CSS properties long hand and avoid adding another tool to a project?

## Benefits

As I have worked with Tailwind, several benefits have consistently risen to the top. Many of these benefits can be implemented with other solutions, but require substantially more effort or maintenance.  A recurring theme is the fine-grained detail of configuration that Tailwind exposes, but only if you need it. 

*Creation of design tokens*: Design tokens are the core of design systems. They are the variables for spacing, fonts, colors, line heights, and more. Strong design systems have rigorous application of these tokens to reduce the usage of one off values. For example, do we really need a margin of 1.125rem when you have 1rem and 1.25rem values? This is a problem that can often present itself in loose or ad hoc systems. Authoring and composing our own design tokens via something like Sass variables can become tedious with vastly different implementations across projects. As such, it's likely to get neglected or fall into time consuming yak shaving. Tailwind, on the other hand, provides reasonable defaults for most design tokens. It also allows us to extend or overwrite portions of the configuration depending on your application needs. Don't need any of the default colors? We can provide our own in the config. Need another spacing variable that Tailwind doesn't provide? We can extend the spacing defaults and provide our own additions. No more trying to override a mass of Sass variables. Furthermore, since the data is already in JavaScript, the values can be shared amongst the rest of the application for the inevitable time when some of the values need to be referenced elsewhere.

*Constrain your system from the beginning*: Design systems work well when the available tokens are pre-constrained to a finite number of options. This helps to reduce analysis paralysis when determining which token to use and also increases the consistency within the application. In an ideal world, these tokens can be shared amongst development and design teams to create a consistent language of building interfaces. Tailwind's defaults provide an excellent and reasonable start to a constrained system.

*Responsive classes out of the box:* By default, Tailwind generates variants of each class across the breakpoints identified. This provides a consistent interface for applying classes across breakpoints.  For example, if we have a flex box that should be column layout on mobile and row with wrapping on medium screens above, we can apply `flex flex-col md:flex-row md:flex-wrap`. Tailwind's responsive classes are mobile first in their application. The `md:` class in this example applies the subsequent Tailwind class at breakpoints medium and up. Like everything else in Tailwind, the breakpoints can also be overriden if the defaults do not meet our needs. This approach is also used for state modifiers such as hover, focus, and active.

*Remove generated classes you don't use: Auto generating many CSS classes can result in shipping unused CSS. However, PurgeCSS takes care of this by eliminating class names not referenced in your project. PurgeCSS is a PostCSS plugin, but is now included with Tailwind as of version 1.4. To use this feature, we [provide an array of patterns](https://tailwindcss.com/docs/controlling-file-size/#removing-unused-css) for templates we want checked. These templates can include framework template files, HTML files, external CSS, etcetera. On build, the plugin will match strings found within those files with the generated Tailwind classes. Any generated classes which are not used in the templates will be removed from the final output. This enables us to have the full spectrum of classes during development, while shipping the bare minimum on builds.* 

## Implementation

Over the past six months, I worked on three projects using Tailwind for the styling. Through the course of these projects I transitioned from being incredibly skeptical of Tailwind, to it being my preferred way to style applications. While the concerns I had up front are commonplace in talking about a utility first CSS approach, I found them less pressing after using Tailwind for a week or so.

The concern of increased class names proved to be mostly a gut response. In practice, I found that creating reusable components which encapsulated styles alleviates the concern of keeping styles DRY. Additionally, the utility class approach helped to increase increase clarity and reduce indirection on several projects.

Tailwind also helped uncover gaps in my knowledge for implementing design systems through tokenization. Creating a constrained system to work within is a significant piece of CSS architecture. The utility first approach of Tailwind goes beyond having CSS shorthand. It is declaring the design tokens your application will use, and generating the necessary classes for a more consistent UI. Vertical rhythm, the spacing of components, can often be plagued by one off values. Working with a consistent and constrained set of values is a dream.

The utility class approach has also enabled rapid iteration. Other implementations have utilized mixins, Sass maps, and other means of capturing design tokens. Retrieving those values often requires knowledge of the given project, what mixins to call, where they live, and how arguments change their behavior. This bespoke indirection adds significant mental overhead, especially for onboarding new developers. Conversely, Tailwind captures the tokens in configuration and then generates class names according to patterns. Editor autocomplete plugins can further reduce friction through inline hints of available classes and the CSS property values they will apply. Another optimization is the ability to apply the same classes within browser dev tools for real time feedback, and then copy the changes to code. These features enabled tighter collaboration with design teams, and opened the possibility of having designers refine styles within the codebase.

Utility first classes don't preclude teams from bundling styles into reusable chunks. There are several ways to address this. First, we can abstract reused styles into their own template partials. This follows the concepts of atomic design and the composition of smaller reusable components to create more complex components. If this doesn't make sense for a given situation, Tailwind offers the [apply directive](https://tailwindcss.com/docs/functions-and-directives/#apply). This directive allows us to create our own CSS classes that wrap any number of Tailwind classes.

```css
.btn {
  @apply font-bold py-2 px-4 rounded;
}
```

At it's core Tailwind creates extensible yet constrained design systems with reasonable defaults. While a utility first approach often causes some initial skepticism, I have found those concerns fall to the wayside after using it. The Tailwind documentation is stellar and helps to mitigate some of this initial friction. The implementation of Tailwind has been a sea change experience in how I approach CSS.
