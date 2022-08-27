---
title: 📓 August 27th, 2022
date: 2022-08-27
tags:
- journal
---
## Family stuff

Nat has been really in to horses lately, so we brought her to a place near Sturgeon Bay to do a quick ride around the arena, she really liked it! We’re also in town to go out to dinner with my parents for my mom’s birthday!

In our downtime today my dad has been using the [Merlin Bird ID](https://merlin.allaboutbirds.org/) app to play bird noises in their backyard and identity birds they can hear, Natalie is OBSESSED with birds lately because Grandpa and her have been doing this once in a while. Its cool to see such a well-done, totally free app, [come from an organization like this](https://merlin.allaboutbirds.org/the-story/).

## Games

I finished up the main campaign of Rollerdrome. Loved it. I’m still playing Yakuza Kiwami and its still wacky as hell. That game is pretty long, so I’ll probably be playing it for a while. I’m dipping back in to Destiny 2 as I do once or twice a year. It’s always hard to get back up to speed with that game, and as a very occasional player I never really full do get back up to speed, particularly because I don’t have a group I play with to do some of the dungeons and raid stuff that require it. I’ve had nice friends who are more into Destiny than me offer but I’ve never taken folks up on it because I know its likely I won’t be committed to playing long-term and often. Fundamentally parts of that game just aren’t for me even if I find the loop and the story compelling, but thats OK.

## Work things

We just finished up our [Headless WordPress workshop](https://reclaimed.tech/headless-wordpress/welcome/#), and I’m really jazzed to try and do some stuff with the things I learned from Jeff and Tom there. I’m also working on documentation on how to run [Flask apps](https://flask.palletsprojects.com/en/2.2.x/) on Reclaim Cloud which is something we get asked about occasionally. I’ve got a [basic Hello World site](https://github.com/TaylorJadin/hello-world-flask), but want to try and set up the Flask documentation’s turorial app, [flaskr](https://flask.palletsprojects.com/en/2.2.x/tutorial/) as well. I’m learning a lot, and I would say python is my most comfortable language, but I’m not sure if I personally dig Flask yet. Maybe once I get through the tutorial I will. 

I’ve been helping a lot of folks this week troubleshoot slow WordPress sites, and I think I want to make a continuously updated list of my favorite WP plugins that I would publish here and keep updated. We at Reclaim have some recommendations that we make in our documentation, but having my own personal list may be helpful, even just as a reference for myself.

## Publishing my hugo blog from iOS

I wrote this one mostly from my phone and iPad using [Notion](https://www.notion.so), [Working Copy](https://workingcopy.app/), and the iOS Shortcuts app while me and the family stayed at my parent’s place in Sturgeon Bay this weekend. I mostly did the draft in Notion (just cuz, I could have done the whole thing Working Copy as it has an excellent Markdown editor built-in) and then moved it over in to Working Copy which is an excellent git client for iOS. I still need to do a proper post on my workflow for using [hugo](https://gohugo.io) on Reclaim Hosting, but basically GitHub is the sync client that gets files to my account. The site then gets built there by running hugo on the server, so having a good git client on iOS is useful for the rare occasions I’m blogging from something other than my computer. When I’m ready to publish from iOS I could use ssh to log in to my cPanel account and [run my build script](https://github.com/TaylorJadin/jadin.me/blob/main/build), but a long time ago I set up a Shortcut on iOS to trigger that script with a simple tap of a button, its neat!