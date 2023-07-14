---
title: "Building a Streaming and Recording setup for Reclaim Open"
date: 2023-07-08T00:13:45-05:00
tags:
- reclaim
- reclaimopen
- av
- streaming
cover:
    relative: true
    image: cover.webp
---

It's been over a month, but I'm finally getting around to writing about Reclaim Open. Reading [Tim's post on his pinball streaming rig for Reclaim Arcade](https://blog.timowens.io/building-a-streaming-rig/) has inspired me to start with the streaming / recording setups we used for Reclaim Open and how that all came together! 

From the early stages of planning Reclaim Open we knew that we would want to do *some* kind of recording of the sessions and keynotes, but we weren't 100% sure what we were going to be able to pull off given we would have to pack and bring any necessary equipment to UMW for the week of the conference. In addition to that, not being able to truly test things out ahead of time in the space you are going to be recording in makes anything like this difficult and nerve-racking. 

My goal was to capture the presenters on camera, as well as capture their screen to get any demos, slides, or videos they were showing. Finally, I wanted some kind of mic setup, so the presenters sounded their best, as bad audio can really ruin any recording. That really comes down to two video sources, and a mix of up to 4 microphones per room (because we had one session with 4 presenters). I do something like this at home (but with just one microphone) all the time using OBS and StreamYard for Reclaim EdTech events, but this would be a lot trickier to do at the conference across two classrooms. On top of that, as much as [I](https://jadin.me/understanding-containers-debrief/) [like](https://jadin.me/starting-obs-with-streamdeck/) [OBS](https://jadin.me/obs-and-streaming-youtubers/) [and](https://video.jadin.me/w/72HZva353wxGsbq5XcQkC2) [what](https://video.jadin.me/w/qQ9FinbCcoNV6gMhEVUoon) [it](https://video.jadin.me/w/9C1qadVNSQibH3tNHYgg5E) [can](https://video.jadin.me/w/4uYeLWmqy3p8zvVeqYwtLQ) [do](https://video.jadin.me/w/eiJvR4FKwLK2c1rFHyKFbE), we weren't going to have a bunch of spare laptops, nor would we have the time to train a team of people to operate a complicated OBS setup in each room. 

## Yolobox Pro

After observing Tim's success using the [Yolobox Pro](https://www.yololiv.com/yoloboxPro) for pinball streams at the arcade, Jim recommended we pick up one to use for Reclaim Open. By borrowing Tim's device and using the one we just purchased, we could record and stream sessions in two classrooms simultaneously. without the use of any laptops or OBS. If you are unfamiliar with the Yolobox Pro, I’d recommend checking out the video below for a pretty good overview of what it can do, and why its interesting:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/dO-iiMo06bU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

If you don’t to watch that[^1], the short story is this is a box that can take multiple video sources via HDMI (or a USB webcam) as well as audio over analog input (or USB). It then lets you switch between those sources as well as mix them and display them in different layouts. You can also do some basic overlays over everything with text, images, and even a built in scoreboard feature.[^2] On top of that the Yolobox itself can record to an SD card, as well as stream over wifi or a cellular connection (it supports sim cards and USB modems). Because of that it truly is a nice portable device that replaces capture devices, OBS, and your laptop in the whole streaming setup!

[^1]: It’s a good video even if the thumbnail makes me sigh.

A quick aside: One interesting thing about that video above is he mentions how cool it would be to able to do stuff like this on an iPad, and I noticed that at WWDC this year one of the smaller announcements was that [Apple is bringing external webcam support to iPadOS](https://developer.apple.com/videos/play/wwdc2023/10106/). This didn’t get much coverage, but I think this could be a big deal, and we could very well see video capture devices designed for iPad in the in the next year or two. If video capture devices come out that work with the iPad and someone puts out good streaming software that can take advantage of these theoretical devices, that might make the Yolobox a bit unnecessary given how much of an advantage in speed has with their Apple Silicon chips. It would be really cool to see what type of devices we are using to stream and record a conference in 2025, it might just be a few iPad minis (and capture devices, cameras, and mics, of course).

[^2]: If I was in charge of coming up with a streaming setup for a high school or middle school athletic department, this device would be a no brainer.

## StreamYard

For streaming the keynotes from the Digital Auditorium I decided I would use [StreamYard](https://streamyard.com/), which we use for a lot of Reclaim stuff, and we're big fans of around here. The advantage of using StreamYard in the auditorium being we could give our keynote speakers a link to join the "call" from their laptops to capture their screen over the internet. This allowed me to stay at the back of the room on the balcony and didn't require the use of a wireless HDMI transmitter / receiver kit or anything else complicated. StreamYard also has some nice OBS-like features that would allow me to add a bit more polish to our keynote streams, like titles and lower thirds, "Getting started" scenes with music etc. On top of that, it's still pretty easy to use, and entirely tied to my laptop (it's all web-based), so if necessary somebody else could step in and take my place relatively easily.

## The Gear`

So with that gameplan, we had the centerpieces of our streaming setups figured out for both the regular sessions and keynotes. Now I just had to figure out the rest of the gear, and how it was getting to Fredericksburg. Some of it was stuff that we bought for Reclaim Open, some was stuff that I already had and could bring along, some was stuff Tim had at the arcade, and some of it we borrowed from [Andy Rush](https://mastodon.social/@andyrush). Thanks Andy!

### Cameras

We needed 3 cameras, and it turned out that between Tim and I we could bring 3 matching [Sony ZV-1](https://www.dpreview.com/reviews/sony-zv-1-review)'s which really made things simple. I love these little cameras, and I use one pretty much every day as my webcam
`
{{< figure src="ZV1.jpg" caption="My ZV1 that I use as my primary webcam. In the flip out screen you can see an image of someone who should be writing this very blog post, but instead is taking a mostly unnecessary picture." alt="A picture of a webcam on a mount above a computer monitor.">}}

;me