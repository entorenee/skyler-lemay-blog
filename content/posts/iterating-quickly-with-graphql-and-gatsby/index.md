---
title: 'Iterating Quickly with GraphQL and Gatsby'
slug: 'iterating-quickly-with-graphql-and-gatsby'
draft: false
publishDate: '2019-03-11'
categories: ['Web Development']
tags: ["GraphQL","gatsby","tooling"]
---
![Iterating Quickly with GraphQL and Gatsby](images/geometric-triangles.jpg#center)

Over the past month I have been adding features to the blog that I had put off for long enough. As I aim to write more, it was time to address some glaring omissions in my initial implementation. This included adding proper category and tag pages, post metadata, and other small features. [Gatsby's](https://gatsbyjs.org/) tight integration with GraphQL enabled quick iteration and development of these new features. Some features required as little as adding a utility field to a GraphQL query to implement.

## Data selection per query
```graphql
query blogPostQuery($id: String!) {
  contentfulBlogPost(id: { eq: $id }) {
    title
    body {
      childMarkdownRemark {
        excerpt(pruneLength: 300)
        html
        timeToRead
      }
    }
    keyQuote {
      childMarkdownRemark {
        html
      }
    }
    headlineImage {
      description
      file {
        url
      }
      title
    }
    headlineImageCaption {
      childMarkdownRemark {
        html
      }
    }
    postTags {
      tag
      slug
    }
    postCategory {
      category
      slug
    }
    postDate(formatString: "MMMM D, YYYY")
  }
}
``` 

One of GraphQL's core features is the ability to select only the required data. A selection set is the specific data requested within a given type. GraphQL uses a declarative data structure. This means that the API consumer specifies the data they need on a per query basis. API developers specify what data fields are available and their associated types. This data structure is powerful and allows responses to only return the data requested. If your data needs change, you update the query and selection set to reflect the new data needs. Gatsby and the `gatsby-transformer-remark` plugin offer several extra utilities. These include retrieving additional metadata and performing basic transformations on the response.

- Date formatter: Gatsby ships with the ability to format the date object to a particular string pattern. For example, adding `postDate(formatString: "MMMM D, YYYY")` to the selection set on one of my blog posts will format the date object to the given pattern. Each query may specify its own formatter pattern, or omit one to receive the date object. This utility eliminates my need for a run-time date formatting library. Reducing your run-time dependencies allows for reduced bundle size and dependencies to manage.
- Time to Read: The `gatsby-transformer-remark` plugin also exposes a `timeToRead` utility field. This parses the estimated time to read the Markdown text and returns an integer. This requires no calculation or data manipulation by the developer.
- Excerpt: Another helpful feature of the remark plugin is the ability to pull an excerpt from the text. The pruneLength argument specifies the number of characters it should include. This eliminates extra substring manipulation on the returned result. An example usage is `excerpt(pruneLength: 750)`. Example implementations include: description tags, overview cards, and blog post indexes.

The ability to add fields quickly is a large selling point for GraphQL. It enables fast development and iteration of new features. Before the release of React 16.8 I wrote up a blog post on [Pragmatic Lessons from Converting to React Hooks](//www.notion.so/blog/2019/02/06/pragmatic-lessons-from-converting-to-react-hooks). I woke up on the morning of release and realized that I never implemented [open graph meta tags](http://ogp.me/). These are an important part of sharing content on social media, and I wanted to have them present before publishing the article. The static tags and dynamic headline reused data that was already within the template component. However, the description field had no corresponding data to pull from. I could have gone back to the CMS to add this field to each post or manipulated the markdown received. This would have been time consuming and blocked the release of the post. Instead, I was able to add an excerpt field to the GraphQL query, set it to 300 characters, and drop the result in the description meta tag. The ability to add new data requirements to the existing query allowed for rapid development of the feature. GraphQL enabled me to develop and deploy the feature in less than 30 minutes.

## Reusing selection sets with Fragments

GraphQL's declarative nature in selection sets can result in duplicate logic for queries which request the same data. This has the downside of bloated code, and relies on updating selection sets in many locations if the data needs shift. Fortunately, GraphQL has a workaround to abstract reusable data selection sets. [Fragments](https://graphql.org/learn/queries/#fragments) take advantage of GraphQL's strict typing to achieve this. They store a specific selection set on a variable for later reuse across queries and other GraphQL operations.

```graphql
fragment BlogPost on ContentfulBlogPost {
  id
  title
  postDate(formatString: "YYYY/MM/DD")
  body {
    childMarkdownRemark {
      excerpt(pruneLength: 750)
      html
    }
  }
  headlineImage {
    title
    file {
      url
    }
  }
}
```

`BlogPost` can be used within queries to request this particular dataset on any `ContentfulBlogPost`. The creation of Fragments adheres to a specific syntax. They start with the reserved word `fragment`, followed by the fragment's variable name. This pattern is like `const` or `let` in JavaScript. After this, you specify which GraphQL type the fragment applies to by adding `on [GraphQL Type]`. Since GraphQL is strongly typed, this asserts that the selected fields are available on the given type. You create selection sets within a fragment the same as within GraphQL queries. Similar to assembling GraphQL queries, you can create and use fragments within GraphiQL to check their validity. Now that you have a fragment defined, it is time to put it to use.

```graphql
{
  allContentfulBlogPost(limit: 500, sort: { fields: [postDate], order: DESC }) {
    edges {
      node {
        ...BlogPost
      }
    }
  }
  allContentfulCategories {
    edges {
      node {
        category
        slug
        blog_post {
          ...BlogPost
        }
      }
    }
  }
  allContentfulTags {
    edges {
      node {
        tag
        slug
        blog_post {
          ...BlogPost
        }
      }
    }
  }
}
```

This snippet executes three different queries against Contentful. Each one gathers data to populate index pages of blog posts, but they each need different structuring of the data. `allContentfulBlogPost` sorts the posts reverse chronologically, while `allContentfulCategories` and `allContentfulTags` organize posts by their respective categories and tags. Despite the different entry points into the graph, their data needs are exactly the same. Adding `...BlogPost` to the selection set, implements the `BlogPost` fragment. Fragments are always used within the same type matching the `on [GraphQL Type]` declaration. GraphQL query tools such as GraphiQL will highlight the fragment if it is being used on the wrong type. Using this fragment makes each query less verbose, and allows them to remain in sync. If the data needs change for the index pages, you change the fragment and each query uses the updated selection set. If a particular query needed more data, you can add the extra field(s) to that specific query. This allows the abstraction of shared data needs, while specifying additional requirements on each query.

The underlying benefit of this query approach is allowing multiple entry points to the graph. This takes advantage of different root data points. The base blog post query returns an array of posts sorted by publication date. This query has no concept of tags or categories. The index page doesn’t display them, and there is no need to request them. The categories and tags index pages do rely on this data to group content. You could query for the category and tag fields in the main query, but this would require manipulation after receiving the results. A cleaner way is to use a query which returns data closer to the structure you need. You can do this by querying for the tags or categories in the CMS and finding the posts associated with them. Using the `BlogPost` fragment, you centralize the data selection data each query needs. This is possible thanks to core GraphQL concepts and Gatsby's implementation of them.

In summary, Gatsby and GraphQL combine for an efficient approach to iterative development. Gatsby has many [source plugins](https://www.gatsbyjs.org/plugins/?=source) which allow adding data to the graph to use these benefits of GraphQL's data selection. Some of the many benefits include:

- Add or remove data fields to a selection set as the component's needs change.
- Take advantage of built in utilities that Gatsby and some of the plugins provide. These include: date formatting, excerpts, and markdown formatting.
- Use GraphQL Fragments to share selection sets across many queries.

GraphQL continues to grow in popularity, and provide benefits to developer experience. For more resources on GraphQL, please check out my [GraphQL resources page](/graphql). If you are getting started with GraphQL, Gatsby is an excellent tool. It's extensive plugin infrastructure offers an approachable way to begin using GraphQL and exploring some of its advantages. Gatsby also provides other site performance benefits such as code splitting and more. For more information, check out their [docs](https://www.gatsbyjs.org/docs/) or [tutorial](https://www.gatsbyjs.org/tutorial/).
