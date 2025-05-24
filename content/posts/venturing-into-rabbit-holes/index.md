---
title: 'Venturing into Rabbit Holes'
slug: 'venturing-into-rabbit-holes'
draft: false
publishDate: '2017-06-30'
categories: ['Web Development']
tags: ['Journal', 'Projects']
---
![Twitch Viewer App](images/2017-06-twitch-v1-1.jpg)

It has been an exciting two weeks in my web development journey. I've made a serious dent in the algorithm challenges since completing my Twitch viewer project. So far I have completed 18 challenges, leaving three advanced algorithm challenges between me and starting my advanced front end projects. These last few algorithms are kicking my butt though, as the difficulty between the intermediate and advanced challenges jumped up the parabolic curve. So far my strategy of stepping away from one challenge and moving to another when I get too frustrated has been paying off. Distance and time has led to some of my best breakthrough moments. Forcing it only pisses me off more, as well as weird looks when I mutter expletives at my computer on public transit.

I also finally made it back to a coding meet up which was long overdue from various scheduling conflicts. These have been so crucial to my growth as a growing developer, and I recommend them to others who are learning as well. Yes that includes even the introverts. I'm far down the introverted spectrum, but pushing past this barrier has paid back many dividends. Some of the many benefits for me are having other people to talk to, bounce ideas of problems and potential solutions off on, and helping out people where I am more knowledgeable--each one has an impact on the learning process deeper than initial appearances.

In a recent meet up I was able to pick the brain of someone who has completed all of the Free Code Camp curriculum (I'm only close to finishing one of the three parts) and had a good amount of experience in React. I'm planning to learn React as my first framework, and it was great hearing some advice from him on great learning resources and some pitfalls. After our conversation, I asked if he would review the JavaScript for my Twitch project and give some honest feedback. He was pretty impressed by how clean and structured the code was, as well as the logic behind it all. It was such a big boost to my momentum and confidence. I know that I can do this, and have code to be proud of in just a couple months.

Last Friday, I had an idea to make my Twitch app substantially more useful—local storage. I kept telling myself throughout the day that I needed to focus on getting the algorithm challenges done, but I could not get the idea out of my head. Eventually I caved, and went down the rabbit hole into learning about local storage and creating the logic to implement it. The logic to implement it was fairly easy and includes an initialize function which populates the local storage with a default array if nothing is stored in local storage already. If there is something stored in local storage, it will only display these users. The end user can now also add or remove users from the viewer for greater customization. Most importantly, due to local storage persisting upon window closure, when the user returns to the page it will display their tailored list without any additional work.

What proved more difficult was creating a collapsible and dynamic user input field to add new users. It took many hours of trial and error, and checking various sources to point me back in the right direction, but I finally achieved the goal. Another valuable lesson was making each function more reusable and restructuring how each one was called/what was passed into it. I'm really proud of the added functionality that came together. The total changes made to create this functionality came out to 362 insertions and 96 deletions.

Now that the Twitch Viewer is up to v1.1 it's time to get back to finishing up these last few algorithms. My goal is to have them completed by this time next week. I already have started to brainstorm on how to structure the logic on my next project, a JavaScript based calculator.
