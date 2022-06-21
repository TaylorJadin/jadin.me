---
title: Embedding and Sharing WebRecorder Archives
date: 2022-06-10
tags:
- reclaim cloud
- reclaim
- domain of one's own
- tools
- site archiving
cover:
    relative: true
    image: snapshot.jpg
---

I've been learning a lot about [Webrecorder](https://webrecorder.net/) and specifically [Browsertrix Crawler](https://webrecorder.net/tools#browsertrix) recently as part of a Web Archiving script that I am working on. The goal is to have a tool you could run on Reclaim Cloud (or your local computer using Docker) that you simply give a URL, and it would make a web archive file using Browsertrix Crawler, and a flattened HTML copy of the site using [HTTrack](https://www.httrack.com/).

The flip side to making those archives is viewing and sharing them. Archives made using Webrecorder or Browsertrix Crawler can be viewed using [replayweb.page](https://replayweb.page/), but I wanted to find the best way to host these on your own server so you can not only view them, [but make them publicly accessible](https://replayweb.page/docs/embedding).

I did some playing around with this over the last week, so I did a quick stream to show what I learned, you can watch the recording below!

<iframe title="Embedding and Sharing Webrecorder site archives!" src="https://video.jadin.me/videos/embed/dcdf1007-b1a3-41ff-bfe8-0542cec6f585" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups" width="560" height="315" frameborder="0"></iframe>