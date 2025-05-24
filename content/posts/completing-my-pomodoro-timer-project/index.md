---
title: 'Completing my Pomodoro Timer Project'
slug: 'completing-my-pomodoro-timer-project'
draft: false
publishDate: '2017-08-13'
categories: ['Web Development']
tags: ['Journal', 'Projects']
---
![Pomodoro Timer](images/2017-08-pomodoro-timer-v1.jpg)

I completed my second project in React last Friday after about 12 hours of development in the course of 5 days. The Pomodoro timer is the second of the four advanced front end certification projects in Free Code Camp's program. I'm getting more excited as I near the end of this particular challenge.

I decided to build this project in React to help solidify my fledgling knowledge in the framework, and because I thought that the use of state and reusable components would be helpful in the project. Both turned out to be true. I feel like I have a much more sold grasp on React now, although I know there is much more to learn and complex things to build. I dove into lifecycles quite a bit more in this project: such as determining when the timer lengths were changed so the countdown component could update, and checking to see if one of the timers had completed so the next one could start. Being able to reuse the counter component for both the session and the break times was great. I really enjoyed only coding it once and adding one small line of code to set which state each one altered.

I tried a number of new things in this project, many of which stayed in the final version. This was my first time incorporating sounds into a project and learning how to import and use different files in JavaScript. After the session or the break timer completes, a gong sounds as an aural indicator that it is time to switch tasks in case the user does not have the timer in the foreground. This was also the first time I imported image files into React, which posed some small challenges making sure I was getting the relative links correct. The one thing that I tried out and eventually eliminated from the final version was using HTML canvas to draw an arc around the countdown timer element indicating the percentage of the timer completed visually. It was great to dabble with HTML Canvas as I had not used it before. In the end, the look wasn't working for me visually and I decided to move forward with a cleaner and flat UI. I did end up adding a bit more depth by using a slight gradient on the timer countdown circle.

It was exciting to complete this project quickly and not needing to reference external resources as often. Whereas, other projects have had me constantly referencing 10+ tabs trying to grasp how to complete something, this one developed fluidly. The next project on the docket list is a Tic Tac Toe game where the user plays against a computer. I have a rough idea of how to structure the game and input, but am currently lost on how to develop the computer. I still have a bit more to contemplate before I decide how I want to build out the app and whether I will be using React again or Vanilla JS. I know that this project will definitely take longer than 5 days to complete. I'm hoping to have most of the app except for the computer player complete this week.
