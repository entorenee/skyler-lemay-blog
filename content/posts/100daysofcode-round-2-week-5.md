---
title: '#100DaysOfCode Round 2, Week 5'
slug: '100daysofcode-round-2-week-5'
draft: false
publishDate: '2018-01-15'
categories: ['Web Development']
tags: []
series: ['100 Days of Code']
---
> The true benefit of converting the logic to a HOC came to light quickly when I started to create the quote slideshow component—it was a simple and efficient process. The creation of the HOC enabled me to reuse all of the logic and keep the component's code dry.

This was a week of pushing myself towards things that I have not utilized before, and confronting things that had previously made me nervous. I decided that I wanted to incorporate a quote slideshow in the About section which would utilize the same basic logic that I had already created for the slideshow. I am not a fan of copying code across files, and appreciate modularity when possible... Due to the carousel component using state and methods which directly alter the state I was not able to simply export the functions. After some research, it seemed like a higher order component would serve the need that I wanted and I decided to finally research them more.

I'm not sure why higher order components had previously intimidated me. As I researched how to implement them to solve the problem, the complexity for this use case was much less intimidating than I thought it would be. Higher Order Components are simply a function which accepts arguments and returns a React Component. The React [docs](https://reactjs.org/docs/higher-order-components.html) provided a great explanation of what they are and how to craft them. After reading through them a couple times I set forth to create my first one. Since I had already written the fully functional Carousel component, I was able to copy out all of the business logic into the HOC, leaving the Carousel component to solely handle the styling and rendering of the data. The arguments I included in the function were the WrappedComponent, an array to iterate over, and the timer length. The latter one is optional, capitalizing on ES6 default arguments. If this argument is not included in the function call, it defaults to 5000ms. Since I also included the array in the HOC, I decided to pass down the entire contents of the current index as a separate prop, `slideData`, for ease of use in the rendering. I refactored the Carousel component to utilize the new HOC and make sure that it still functioned the same. Everything worked great and still passed all of the previous tests. Mission success.

The true benefit of converting the logic to a HOC came to light quickly when I started to create the quote slideshow component—it was a simple and efficient process. The creation of the HOC enabled me to reuse all of the logic and keep the component's code dry. I created an array of quotes, the display UI to render, and exported the returned component from the HOC function. I was beyond sold on higher order components and wondered why I had put off looking into them for so long.

I also decided to jump into using ESLint finally. I'm not sure why I had not started using it sooner, but it had always been on the back burner. I sorted out how to get it set up using the AirBNB style guide and React extensions. The biggest issue that I ran into was sorting out the conflicting rules between Prettier, which I have been using to auto-format my code for 4 months and some of the style rules that ESLint was trying to implement. I was able to solve most of these issues by running Prettier through my ESLint configuration instead of the VSCode extension. The remaining issues required turning off a couple of the ESLint rules to allow the Prettier formatting to take priority. Even though I had never run ESLint on a project before, I did not have too many errors listed on the project and most of them were fairly minor. I corrected the errors that were easily identifiable, and looked at the documentation for any errors where I did not understand the rule that was being flagged. This helped me to understand many small areas where my code could be improved in the future in pursuit of best practices. Now that all of the code has been caught up to be compliant with my linting rules, it will be easy to stay on top of it as I am coding.

Lastly, I began my foray into playing with CSS Grid. I wanted to create some more asymmetric design elements in my web site, and specifically the About section, which would not be readily completed with my previous CSS layout tools. It started off slow, as is the case with most new things, but I started to make progress on some very basic implementation of it. It still needs a lot of work, but at least I finally started.

I'm really proud of the progress that I made this week. I incorporated three new and important aspects into my development tool belt and made good progress on my project. In addition, I wrote and published my 2017 Year in Review post. It was great to reflect on finding my passion in programming and the difference that 8 months can make. 

## The Week in Review

* Day 29: I mostly finished up my first higher order component so that I can reuse the slideshow/carousel logic. Functionality was reached, but it still needs some cleanup.
* Day 30: The carousel component was refactored to use the new higher order component. I also started to create a quote slideshow component using the same higher order component.
* Day 31: I researched some new things in React and made good progress on my year in review post.
* Day 32: I wrote about 1600 words on my year in review post and finally looked into and set up ESLint. Thankfully, there weren't errors everywhere. That's always a good sign.
* Day 33: I completed and committed my year in review blog post and completed a couple more job applications.
* Day 34: I started to play around with CSS Grid and some design changes to the About section on my website. I also added a few more tests to the website and made some tweaks to the ESLint configuration. It now plays well with Prettier.
* Day 35: I resolved the remaining ESLint errors in my project and made some progress with my exploration into CSS Grid.
