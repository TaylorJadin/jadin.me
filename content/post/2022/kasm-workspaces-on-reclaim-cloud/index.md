---
title: Messing around with Kasm Workspaces on Reclaim Cloud
date: 2022-04-27
tags:
- reclaim
- reclaim cloud
- docker
cover:
    relative: true
    image: kasm-cover.png
---

At the end of the day today I streamed a little bit of me playing around with [Kasm Worskpaces](https://www.kasmweb.com/) on Reclaim Cloud:

<iframe title="Messing around with Kasm Workspaces on Reclaim Cloud" width="720" height="480" src="https://video.jadin.me/videos/embed/4d226d33-3194-47a7-921b-9a16c58d2dae?start=4m32s" frameborder="0" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups"></iframe>

The tool seems interesting and it has been on my list of things to look into for a little while. It's basically a self-hostable Desktop-as-a-Service (DaaS), like Citrix or Amazon Appstream, but for Linux Desktops and applications. Also, it has a free version!

Under the hood it all runs on Docker, which is how I found out about it. I stumbled on this [curious image on DockerHub](https://hub.docker.com/r/kasmweb/doom#!) last week and had to try it out:

<video style="max-width:100%" autoplay loop muted controls>
	<source src="kasm-doom.mp4">
	Your browser does not support the video tag.
</video>

Honestly, to my suprise I was able to succesfully get it working in the timespan of a 40 minute stream 🎉🎉🎉

