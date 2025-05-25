---
title: 'Pragmatic uses for React Context'
slug: 'pragmatic-uses-for-react-context'
draft: false
publishDate: '2019-07-24'
categories: ['Web Development']
tags: ["react","react-hooks"]
---
![Pragmatic uses for React Context](images/chains-perspective.jpg#center)

The purpose and use case for the React Context API long eluded me. I was familiar with what it did in principle, but struggled to find a use case for it. The Context API can solve some unique problems such as: grouping localized text strings and creating a language provider. In this post I share how the Context API can help solve these problems, as well as some sample code.

According to the [React docs](https://reactjs.org/docs/context.html):

> Context provides a way to pass data through the component tree without having to pass props down manually at every level

## Passing Localized String Props

Localized applications bring a host of various complexities, one of which being an increase in the amount of props for localized text. The removal of any hard coded text strings can quickly balloon to an addition of 15 or more localized string props in a medium sized module. For flat component structures this may not pose much of a problem, as the props are passed down a level or two. However, this quickly grows out of hand for modules which have a deeper component structure. This leads to excessive prop drilling, which becomes more confusing as the number of props increases. It becomes harder to track which props a component is using, and which props it is passing farther down the tree. Complex modules can introduce additional bugs by not properly passing the prop down the tree or through accidental prop removal. 

React Context helps to resolve this problem by inserting the localized props into a context provider at the root of the module. Any sub component of the module can subscribe to the context and access the values it requires. This reduces prop drilling and clarifies the prop structure of each component. This results in components which are easier to reason about, maintain, and debug.

```javascript
import React from 'react'
    
export const SharedStrings = React.createContext({})
    
const MyModule = props => {
  const { headlineText, labelText, username, submitButtonText } = props
  const providerValue = { labelText, username, submitButtonText }
    
  return (
    <SharedStrings.Provider value={providerValue}>
      <h1>{headlineText}</h1>
      {/* children and nested components */}
    </SharedStrings.Provider>
  )
}
    
export default MyModule
```

## Creating a Global Language Provider

Another helpful application of Context is tracking a user’s selected language for multi-lingual support. An application may use a specified query parameter to determine the desired translation of a page, such as `?lang=en` or `?lang=es`. In this case, a Language Provider component can watch for the translation key to change and update the value of the context. Wrapping the entire application creates a straightforward subscription process for components. This provider may look something like:

```javascript
// language-provider.js
import React, { useEffect, useState } from 'react'
    
const allowedLanguages = new Set(['en', 'es', 'fr'])
    
// Context for consuming components to import
export const LanguageContext = React.createContext('en')
    
/* Check that the paramString has the lang attribute and is in the allowed set
 * otherwise default to English
 */
const parseSearch = paramString => {
 const lang = new URLSearchParams(paramString).get('lang')
 return allowedLanguages.has(lang) ? lang : 'en'
}
    
// Location as a prop from the Router
const LanguageProvider = ({ children, location: { search }}) => {
 const [selectedLanguage, setSelectedLanguage] = useState(parseSearch(search))
    
 useEffect(() => {
  setSelectedLanguage(parseSearch(search))
 }, [search])
    
 return (
  <LanguageContext.Provider value={selectedLanguage}>
    {children}
  </LanguageContext.Provider>
 )
}
    
export default LanguageProvider
```

This approach works well for requirements where the url remains the same for all versions of the localized content, adjusting what is rendered based off the current value of the context. Components which use this pattern, can receive props for both languages as displayed in the example component below. One downside to this approach is the added collocation of data. While this may be beneficial in smaller scale applications, or ones with limited supported languages, this approach may not be ideal for applications which do not meet these criteria. Too many supported languages can result in a bloated props object. This use case may be better served by unique routes per supported language.

```javascript
// headline.js
import React, { useContext } from 'react'

import { LanguageContext } from '../language-provider'
    
// Example props that component may receive from a CMS
const props = {
 en: {
  title: 'Hello World',
 },
 es: {
  title: 'Hola Mundo',
 },
 fr: {
  title: 'Bonjour le monde',
 },
}
    
const Headline = props => {
 const selectedLanguage = useContext(LanguageContext)
 const {
  [selectedLanguage]: { title }
 } = props
    
 // Title will update when the context changes
 return <h1>{title}</h1>
}
    
export default Headline
```

These are just a few examples where React Context can fill a unique need. I have used both of these examples in production applications and found the use of Context simplified the approach to the problem. There are many more use cases for Context, and the React docs provide some great considerations on [when to use Context](https://reactjs.org/docs/context.html#when-to-use-context). In short, Context can help resolve painful cases of prop drilling, but it can tie your components to specific use cases or structure. It is not the tool to solve all your prop passing woes, but does solve some problems in an elegant manner.
