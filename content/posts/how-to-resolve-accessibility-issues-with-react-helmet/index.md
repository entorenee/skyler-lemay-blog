---
title: 'How to Resolve Accessibility Issues with React Helmet'
slug: 'how-to-resolve-accessibility-issues-with-react-helmet'
draft: false
publishDate: '2019-05-28'
categories: ['Technical']
tags: ["react","accessibility"]
---
![How to Resolve Accessibility Issues with React Helmet](images/book-reading-with-coffee.jpg#center)

The `lang` attribute is an essential part of the HTML element. It identifies the main language of the document's content. This is used by screen readers to determine the pronunciation of words. Screen readers have a default language setting, but will respect the language specified in the `html` element if they differ. However, if this attribute is missing, and the language of the document is different than the screen reader's settings, the user will receive a subpar experience with incorrect pronunciations. For more information on the accessibility of this attribute, check out Deque University's [detail page](https://dequeuniversity.com/rules/axe/3.2/html-lang-valid).

## React Helmet and JSX

In many React development scenarios, the shell HTML template is not immediately available to the developer. In other instances, it may not be desirable to hard code the `lang` attribute into the HTML template, such as localized sites. [React Helmet](https://github.com/nfl/react-helmet), solves both of these situations. React Helmet is a lightwight (6.4 KB gzipped) utility library that allows you to dynamically set the contents of the `head` element. This includes setting open graph tags, meta information, title, and more. It also allows for setting attributes on the `html` element itself.

```javascript
import React from 'react'
import Helmet from 'react-helmet'
    
const HardCoded = () => (
  <Helmet htmlAttributes={{ lang: 'en' }}>
    // any tags you want inside <head>
  </Helmet>
)
    
const DynamicLang = ({ lang = 'en' }) => (
  <Helmet htmlAttributes={{ lang }}>
    // any tags you want inside <head>
  </Helmet>
)
```

Helmet is also composable, meaning that usage farther down the component tree can provide overrides to a parent instance. For example this site provides a base configuration of meta tags on the Layout component, and then overrides or adding tags at a lower level. This includes the page title, changing the `og:type` from website to article, updating the `og:image` tag, and more.

I have found the use of Helmet to be preferable to setting these fields in an HTML template. Instead, I reserve the usage of adding items to the static template for global items that I do not want to change across the entire implementation, such a s global font assets. However, if there are certain font assets that are only needed in certain pages of an application, they can be added with Helmet at a lower level. This eliminates loading these assets until they are needed.

In summary, please check that your `html` element has an appropriate `lang` attribute set for appropriate accessibility. It is an easy win from a development perspective, but makes a substantial difference in screen reader usage. We can make substantial impacts on the usability of a site without being accessibility experts.
