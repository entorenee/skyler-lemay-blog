---
title: 'How to Configure Jest for Vue apps Using Vuetify'
slug: 'how-to-configure-jest-for-vue-apps-using-vuetify'
draft: false
publishDate: '2019-10-09'
categories: ['Web Development']
tags: ["today-i-learned","testing","tooling"]
---
![How to Configure Jest for Vue apps Using Vuetify](images/abstract-pink-blue-connections.jpg#center)

I have recently been working on a Vue project which utilizes [Vuetify](https://vuetifyjs.com/en/) for the base of some of it's components. Vue has the ability to register components globally, eliminating the need for importing base components. This works great in development, but I came across an error when testing the component with Vue Testing Library.

![Vue console error for using a globally registered component that could not be found](//images.ctfassets.net/024qyvhyq0tv/7AfHG8d3abH5rJHWaN4gpT/0cc6c0c0f8d85b29355ce1ed60abfc61/image.png)

This error occurred because Jest had not been configured to recognize Vuetify's global components. In order to resolve this, some additional information was required in the Jest setup file.

```javascript
// jest/setupFiles.ts
import '@testing-library/jest-dom/extend-expect';
import Vue from 'vue';
import Vuetify from 'vuetify';
    
Vue.use(Vuetify);
    
// Required for Vuetify
const app = document.createElement('div');
app.setAttribute('data-app', 'true');
document.body.appendChild(app);
```

First, we need to import both Vue and Vuetify in the setup file. By calling `Vue.use(Vuetify)`, Jest becomes aware of the plugin and the globally available components it provides. This solved the console error, but introduced a new warning, that no `<v-app>` or div with a `data-app` attribute was found. Vuetify requires one of these at the root of the application in order to mount its components to the page. Creating a div with this attribute and appending it to the body resolves this warning.

Now we have a test environment in jsdom that mirrors the requirements for Vuetify and can proceed with integration testing. Currently I have been using [Vue Testing Library](https://testing-library.com/docs/vue-testing-library/intro) for integration tests with good results. It uses Vue Test utils under the good, while hiding some methods that can encourage implementation testing practices.
