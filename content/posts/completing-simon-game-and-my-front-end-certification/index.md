---
title: 'Completing Simon Game and my Front End Certification'
slug: 'completing-simon-game-and-my-front-end-certification'
draft: false
publishDate: '2017-08-27'
categories: ['Projects']
tags: ['Projects', 'React', 'Learning', 'Web Development']
---
![Simon Game](images/2017-08-simon-game.jpg#center)

On Saturday night, the 150th day since I started my coding journey on [Free Code Camp](http://freecodecamp.org), I completed the Simon Game project and claimed my front end development certificate. It's been an amazing start to my journey as a developer, and I'm amazed at how much I have learned in such a relatively short period of time.

The Simon Game project was definitely the most challenging of the advanced front end projects. Most of the HTML and CSS for the project I was able to create within a couple days. The circular divs comprising the colored buttons were relatively straightforward to create and position. Setting up an SVG circle inside the container housing the game buttons was also simple. I used the SVG to provide visual feedback if the player successfully completed a step in the game. I used React for this project as well and fully embraced the concept of components. The game board buttons, start button, and strictMode toggle are all their own components. Using components for this made sense as it keeps the logic more separate and avoids having a huge render method.

The Javascript was a much bigger bear. This was largely due to timing issues within the game. A significant part of the Simon Game involves showing the pattern that the player is supposed to match. Each of the colored buttons lights up in a particular order that the player is supposed to remember and mimic. When showing the pattern, we only want to light up one button at a time with a slight pause in between the buttons corresponding to a note played. The pause is necessary as if there is a repeat button, we want to be able to see it highlighted twice. Playing audio could also be layered more easily. Originally, the showPattern method looked like the below code snippet. Which sets a timer for each pattern node, each one running 800 ms after the previous one.

![Firefox running Simon game](images/2017-08-simon-firefox.jpg)

I thought this was working fine, but as I got into checking the feedback from the tests, I ran into a major issue. The Free Code Camp tests were failing because the timer in setTimeout is not 100% accurate. For example in setInterval(callback, 1000), it isn't guaranteed to be exactly 1000ms. It will be very close, but there may be a few milliseconds of unaccounted time. What was happening is toward the end of the pattern, the timers were off enough that buttons which should illuminate one after the other (strictly sequentially and never at the same time), were showing partially at the same time. I couldn't understand at first why the buttons sometimes appeared to flicker or illuminate together. I was pulling my hair out over this problem for several hours. The issue was highlighted further when I ran the tests in Firefox. Chromium browsers, such as Chrome and Opera, were still just barely passing, while Firefox was failing completely.

I re-architected the showPattern method to use a variety of promise based callbacks which ensured that no matter how long the animation and audio for a particular pattern took, the next one wouldn't start until the current one was fully complete. This was a huge revelation for me and made me realize how problematic my original approach was, despite it seeming to work most of the time. The only other large hurdle in the project was around the logic of checking the button pressed against the pattern. With console logging it in various ways it became a lot easier to debug.

I'm really looking forward to beginning the next journey on Free Code Camp which focuses on more back end style development with Node.js, Express.js, and MongoDB. I'll be looking to balance this with finishing React modules that I already have started on Pluralsight, and continuing to work on my portfolio site. Next week I'm also starting a program in full-stack Javascript at a local coding school called Alchemy Code Lab. I'm both excited and a bit nervous for what that journey will be like, but I'm sure it will be a very valuable experience.
