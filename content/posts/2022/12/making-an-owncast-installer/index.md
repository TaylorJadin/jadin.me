---
title: Making an Owncast installer for Reclaim Cloud
date: 2022-12-22T14:09:38-0600
tags:
- cloud
- reclaim
cover:
    relative: true
    image: owncast-marketplace.png
---

Today I did a stream where I attempted to create an [Owncast](https://owncast.online/) installer live in about an hour. I have used Owncast before, and [used Jim's blog post to set it up manually](https://bavatuesdays.com/installing-owncast-on-reclaim-cloud/), but that's mostly all the prep I had done beforehand. Having just come off of setting up a Mastodon installer, greatly helped as I learned a lot from that experience, and was able to re-use a lot of stuff from it.

I ended up kind of flying through everything, as I felt like the clock was ticking, so it may not be the best explainer, but if are curious how to run things in docker-compose and how our Reclaim Cloud installers work, you may find it an interesting watch, or skim.

<iframe title="I'm going to try and make an Owncast installer real quick" src="https://video.jadin.me/videos/embed/b8813f4c-3e9f-45dd-b32f-94ecb4cf67b1?start=5m30s" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups" width="560" height="315" frameborder="0"></iframe>

Oh, and that installer is live in the marketplace now! I did end up including add-ons to make updating and domain configuration 1-click, [like our Ghost installer](https://jadin.me/new-ghost-installer/). I didn't end up streaming the part where I made the add-ons, but that basically amounted to me [borrowing some stuff from my Ghost installer](https://github.com/TaylorJadin/Ghost-docker-jps/blob/66c44b338f5086d3d400ffc5f7584b12096ee91e/manifest.jps#L97). Go check it out if you want to try out a self-hostable live video server!