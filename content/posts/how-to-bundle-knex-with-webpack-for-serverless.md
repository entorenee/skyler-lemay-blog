---
title: 'How to Bundle Knex with Webpack for Serverless'
summary: "Solve Knex bundling issues with Webpack using NormalModuleReplacementPlugin for cleaner serverless deployments."
slug: 'how-to-bundle-knex-with-webpack-for-serverless'
draft: false
publishDate: '2020-05-22'
categories: ['Technical']
tags: ["today-i-learned","tooling"]
---
Bundling [Knex](http://knexjs.org/) with Webpack doesn't always play well. In this particular case I was trying to bundle a serverless application with only the runtime dependencies. Since this project was utilizing TypeScript and other tooling and dev-dependencies I definitely did not want to ship all of the node modules. Additionally, most of the 10 module resolution errors I was receiving were for packages I didn't even have installed. In this blog post we'll cover utilizing a Webpack plugin to resolve this build error.

I'm still not entirely sure why this error occurs, but judging by GitHub issues it has cropped up several times with individuals sharing different solutions. In order to properly bundle the application with only the required dependencies, I ended up reaching for Webpack's [NormalModuleReplacementPlugin](https://webpack.js.org/plugins/normal-module-replacement-plugin/). This plugin accepts two arguments. The first is a regular expression of packages to match, and the second is a module to use in its place. Using this plugin in combination with with the [noop2](https://www.npmjs.com/package/noop2) npm package allows us to selectively ignore dialects that the program is not utilizing.

```javascript
new NormalModuleReplacementPlugin(
  /m[sy]sql2?|oracle(db)?|sqlite3|pg-(native|query)/,
  'noop2',
)
```

After adding this to the Webpack configuration, everything compiled without error and only brought along the necessary dependencies. Below is a copy of the entire Webpack configuration for the project.

```javascript
/* eslint-disable @typescript-eslint/no-var-requires */
const path = require('path');

const slsw = require('serverless-webpack');
const nodeExternals = require('webpack-node-externals');
// Package is installed via serverless-webpack
// eslint-disable-next-line import/no-extraneous-dependencies
const { NormalModuleReplacementPlugin } = require('webpack');

const { isLocal } = slsw.lib.webpack;

module.exports = {
  mode: isLocal ? 'development' : 'production',
  devtool: isLocal ? 'eval' : 'source-map',
  entry: slsw.lib.entries,
  output: {
    libraryTarget: 'commonjs2',
    filename: '[name].js',
    path: path.join(__dirname, '.webpack'),
  },
  externals: [nodeExternals(), 'aws-sdk', 'prettier'],
  target: 'node',
  resolve: {
    extensions: ['.js', '.mjs', '.cjs', '.json', '.ts'],
  },
  module: {
    rules: [
      {
        test: /\.(ts|js)$/,
        exclude: /node_modules/,
        include: __dirname,
        use: [
          {
            loader: 'ts-loader',
          },
        ],
      },
      {
        test: /\.mjs$/,
        include: /node_modules/,
        type: 'javascript/auto', // Necessary for properly resolving mjs
      },
    ],
  },
  plugins: [
    // Ignore knex dynamic required dialects that we don't use
    new NormalModuleReplacementPlugin(
      /m[sy]sql2?|oracle(db)?|sqlite3|pg-(native|query)/,
      'noop2',
    ),
  ],
};
```
