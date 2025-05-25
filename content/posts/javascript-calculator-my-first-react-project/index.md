---
title: 'JavaScript Calculator: my First React Project'
slug: 'javascript-calculator-my-first-react-project'
draft: false
publishDate: '2017-08-06'
categories: ['Projects']
tags: ['Projects']
---
![JavaScript Calculator](images/2017-08-javascript-calculator-v1.jpg)

After much debugging and chasing of state errors for edge cases of operational order, I have finally concluded the development of my JavaScript calculator, which also happens to be my first React application. This particular project stretched me the most thus far for multiple reasons. Learning a new library was definitely complex and took some back and forth researching (more on that later). The primary challenges was handling all of the logic necessary to operate the calculator and then handling a bunch of unexpected cases and order of operations that would break the ideal scenario's code. Due to the complexity of handling the various states[^1] in React and the need for each state to be populated in a certain manner for equations to not error out, I had to intentionally try to do operations incorrectly to make sure that the calculator would handle the incorrect or less than ideal operations patterns successfully. Solving one bug, created others in some cases and was a very valuable lesson in bug tracking and solving.

The bug tracking and resolving solidified my respect for branching the code often to search for solutions. This made it easier for me to abandon a venture if it wasn't working out without doing a bunch of resets on the semi-stable code base and also compare the two more effectively if necessary. I didn't really start doing this until the bug troubleshooting phase, but I am starting to see how it could be more beneficial in the primary development as well even as a single developer.

As far as React is concerned, I really appreciate the compartmentalization mindset it brings as it makes the code more manageable when looking to change something. While the codebase for this project is nowhere near a large scale project, I could see the benefits nonetheless, and I imagine that the benefits increase as the project scales up. I wouldn't use it for a really simple project, but think that it was a good fit for this project as opposed to Vanilla JavaScript.

The main learning resource that helped to kickstart my understanding of React was the excellent course by Wes Bos at [React for Beginners](http://reactforbeginners.com). Wes does a great job explaining the various stages of building a React app, how to handle properties and state, authentication with Firebase, and more. What really helped me was building out an actual application while following the videos. I referenced the videos and the code written through the course multiple times while building out this app, and I know that the learning process would have been substantially longer had I not started with his course. I have no affiliation with Wes or his courses, but am a highly satisfied customer who will likely look to his other courses should I desire to learn their topics. The basic package of the course is currently $72 and the full package is $98. I highly recommend it as a resource if you a just starting to learn or want to learn React.

I again decided to go a bit beyond the user story requirements for the Free Code Camp project by implementing percentages and the ability to toggle a number from being positive or negative. I'm happy that I did this as dealing with the percentages required a slightly different way to handle responses when the button is pushed depending on what value is being modified. Additionally, thanks to the recommendation of a friend, I decided to add keyboard support for this app which was also a first for me. I can understand why FCC doesn't expand the projects to include more nuances and edge cases like these. For me, the added challenge of figuring out how to do something that I had not done before or that may require some more nuanced logic, was valuable. It stretched me a little bit more, and I believe helps to prepare me for future problems.

The next project that I am starting and have a rough game plan for is a version of the Pomodoro timer. This is the second of the four advanced front end projects for Free Code Camp. I'm also looking at developing that project in React.

[^1]: There are a total of 4 states managed within the calculator app: the display, the previous value in an operation, the current value being manipulated, and the operand stored to complete an operation.
