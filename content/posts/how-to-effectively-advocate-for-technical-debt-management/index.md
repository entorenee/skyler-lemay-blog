---
title: How to Effectively Advocate for Technical Debt Management
summary: "Approaching technical debt as an Engineering vs Product problem is a common fatal mistake. Learn collaborative strategies for effective technical debt advocacy that unite teams around shared business outcomes."
description: Approaching it as an Engineering vs Product problem is a common fatal mistake
slug: how-to-effectively-advocate-for-technical-debt-management
draft: false
publishDate: 2025-06-16
cover:
  image: images/pexels-gili-pup.jpg
  alt: A brown dog and black dog are playing tug of war with a short and frayed red rope. Both dogs are crouching as they play for the rope in a field of grass.
  caption: Two Dogs on Green Grass Field by [Gili Pup](https://www.pexels.com/photo/two-dogs-on-green-grass-field-11545918/). Creative Commons License.
categories: 
  - Career Development
tags:
  - leadership
  - team-health
  - systems-design
  - code-quality
---
Technical debt management is one of the most substantial and persistent dynamic tensions in engineering. Features need to be built and launched including experiments which may be scrapped entirely. Clean maintainable code doesn't matter much if the core business or service isn't sustainable. Unmitigated technical debt can also grind feature development to a standstill and result in an engineering whack-a-mole bug chasing nightmare. In my experience, this issue is one that is also framed as _Engineering vs Product_. This is the wrong approach and only increases the tension and adds more friction to the overall process.

I'm passionate about the solutions that I help create and of course want them to be as well crafted as possible. I have successfully lead teams which were called out as having projects with clear onboarding instructions to help new contributors jump into the thing that matters first. Creating clear modules and systems helps to define the areas of concern and know where in a system a particular feature belongs. If something breaks, it helps to narrow down what portion of the system has an issue. Quickly standing things up is great to roll out and test things, and it comes with the added cost that all of those little branches in the code continue to grow into a combinatorial complexity object of horror that no one wants to touch. 
## Shift From Oppositional to Collaborative
The most effective engineers are able to not only collaborate with other engineers, but to work with their peers across product, design, and engineering leadership. I've tried all sorts of approaches to both incrementally and more substantially make improvements to technical quality with varying results. Yes it may feel good and make technical sense to speak strongly about why something is technically important, but if this is framed in an oppositional context placing engineering versus product advancement the latter will succeed in most cases. The infamous [microservices sketch](https://www.youtube.com/watch?v=y8OnoxKotPQ)  satirically highlights this tension. From my experience, the underlying issue is approaching the problem from a perspective of opposition rather than one of collaboration.

A couple years ago I was leading my team's portion of a massive initiative to change a core business model from a one-to-one relationship to a one-to-many relationship. This was not the time to bolt more things onto the system, but to review the system as a whole and align it with the shifting business direction. Of course we wanted to deliver this as quickly as possible, but the scattered approaches over the years were starting to show their weaknesses. We needed to both pivot our technical approach for future sustainability and work across teams to launch this large project. As an engineer, we love to dive deep into the technical problems. However, those rarely make sense to others outside engineering. Sometimes they don't even make sense to engineers outside of the immediate team. The weeds may run so deep that it is hard to portray to Engineering Managers. I needed a different approach and the following metaphor provided a much needed connection:

> You are the owner of a home. Over the years you have built out various additions to it, increased your baseline energy consumption, and made the home more to your liking. Projects have been getting more complicated though. Breakers start popping if multiple appliances kick on at the same time, and you increasingly deal with power fluctuations.
> 
> The wiring in the house is showing it's age. It's not at an absolute failure point, but this is something that is hard to monitor. You want to get some more projects done in the house, but there is an increasing risk associated with them. This slows down the projects and if the issues aren't tended to, an electrical fire could result in catastrophic damage. Rewiring the house and upgrading the electrical panel isn't exciting work. It is far less appealing to the eye than that bathroom remodel in mind. However, investing in that work protects the integrity of the house you have built thus far and reduces the friction of future projects. The value of the project is both risk mitigation and forward thinking. It is a project to help enable the bigger and exciting projects you have planned.

Things started clicking. Yes I was thinking about data modeling, module and domain boundaries, and creating consistent interfaces. That work can be important and vital to long term health, but if only a select few know the details of that, it's likely to get left on the cutting room floor for prioritized work streams. I learned that lesson the hard way far too many times across multiple companies and teams. I'm not an electrician and beyond a few key terms and phrases won't really understand the electrical issues going on in a home. I may try and understand some of the terms to be able to better communicate with them or for my own gut checks on the proposals I'm given. An electrician could share all the technical details of why rewiring needs to be done. They likely still will include that as an addendum or justification for those who need or want to dig into those details. However, the bigger narrative is the selling point—we need to rewire the house or you could have an electrical fire which could jeopardize everything.
## Strategies for Approaching Technical Debt Mitigation
Shifting to this mental model of unifying multiple disciplines towards a common goal with a shared language has enabled numerous large technical shifts. An initial phase of refactoring focused primarily on maintainability and consistent patterns. We didn't expect to see much user facing impact, but would have a more stable system overall. To my surprise, this cleanup also resulted in key service endpoints reducing their latency by 50-70%. We started building up some momentum. However, the dynamic tension will always be present and I would argue is value neutral.

Organizational structures and historical context of that tension may skew it away from a neutral position, but the tension itself is valuable. We need to have the right balance of features which deliver value or growth to the end user while also maintaining the stability of that feature set. Navigating the balance of that is something that is in the best interest of all parties involved. I was thankful to be part of a healthy collaborative team where we could approach and discuss these diverse perspectives and needs. That being said a single metaphor, including permutations of it, can only go so far. The next iterations of improvement required engineers to dive deeper to the language of their colleagues. The following questions are a starting list of perspectives I have found useful in those conversations:

**User Focused:**
* How does this affect the experience of the end user? Does it improve it? If so, how?
* How does it reduce bugs? Does this resolve a few cases or resolve an underlying system of bugs and bug reporting?
* How does it reduce cognitive complexity which can both impact team effectiveness and contribute to more bugs?
* How is this investment tied to historical incident data, poor user experiences, or resolving recurring bug cases?

**Team Effectiveness Focused:**
* How does this impact velocity and the ability to deliver features? Does this reduce blockers to feature development?
* How does it enable other teams to contribute more effectively? In the case of a service which is primarily maintained by one team and others contribute, what are the obstacles presented for other teams? How easy is it to follow consistent patterns? How does that impact PR cycle time?
* How can we reduce developer friction on things like this in the future?

**Business Focused:**
* What makes the issue a priority? What are the risks if it gets pushed down the road? How does this apply to a stack ranked series of objectives?
* How can we measure the effectiveness of this change?
* How does this work enable future product goals or eliminate blockers to pursuing those goals?
* What are the hidden costs of not addressing the issue?
## TLDR: Effective Engineering Leaders Work Closely with Their Cross Discipline Counterparts
Approaching technical debt management from a philosophical and technical standpoint is the wrong move, even if the technical perspective is sound. Effective engineering leaders can capture those technical complexities and present them to their counterparts in ways that capture a collaborative perspective and how this impacts the greater picture. It doesn't matter if engineers are fully justified in why something is important, but are unable to communicate that across disciplines. This feeds into the Product vs Engineering dichotomy. While this dynamic tension can be skewed based on organizational culture, the tension itself is value neutral and something good engineering leaders work within.

I'll conclude with one final anecdote of this approach proving effective where philosophical arguments fell short. Feature flags and environment variables are a common means of gating against launching new features before they are ready, especially when those features are built in products using continuous deployment or work that spans longer than a single sprint. They can also be hard to prioritize cleaning up—coming ahead of maybe dependency management.[^1] Things just work as they are now so why would we use engineering cycles to clean things up? Sometimes these experiments can compound and dramatically increase engineering complexity, but it is still harder to argue the case to clean them up compared to other needs. However, there can often be a hidden cost or failure point If determining the value of a flag relies on an external first or third party service. What happens if that service or abstraction fails? What is the end user experience? Does it default to a control experience? What are the implications from an overall product perspective if this were to happen? In this particular example, the end user experience would have been an older version of a flow which was not desired at all. Engaging in these discussions and digging into the bigger picture questions helped us to highlight the most important things to promptly clean up and mitigate that risk.

[^1]: Tools like Renovate can help increase the automation of dependency management as I've written about [here](/blog/better-dependency-management-using-renovate/).
