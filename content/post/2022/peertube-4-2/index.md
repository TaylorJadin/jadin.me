---
title: Peertube 4.2!
date: 2022-06-21
tags:
- reclaim
- reclaim cloud
- docker
- peertube 
cover:
    relative: true
    image: 
---

[Peertube 4.2 is out and it has all kinds of features I'm excited about](https://joinpeertube.org/news#release-4.2) like in-place editing of videos, replays of recurring live streams (basically you can have a permanent Twitch-like url where you can go live but then the recording of that livestream can be automatically made available afterward), latency settings for livestreams, and a bunch of other stuff. 

I wanted to get my Peertube instance on Reclaim Cloud upgraded, which is a docker-compose setup with the [Live Chat plugin enabled](https://github.com/JohnXLivingston/peertube-plugin-livechat), so I stopped the containers, pulled changes, and started the containers again.

```bash
docker-compose down
docker-compose pull
docker-compose up -d
```

While this did seem to pull some updates, I didn't see much of anything change in the web ui for Peertube, and my Live Chat was busted!

## Fixing Live Chat

After using `docker-compose logs -f` to look at the logs. I tracked down a [Github issue that seemed similar to my problems with the Live Chat plugin](https://github.com/JohnXLivingston/peertube-plugin-livechat/issues/99#issuecomment-1160567713)[^1]. A temporary work around while the developer of the plugin gets things updated for Peertube 4.2 is to add this line to edit the following file in the docker-volume folder: `docker-volume/data/plugins/node_modules/peertube-plugin-livechat/dist/server/lib/prosody/config/content.js`

On line 87, after the line that begins with `this.global.set('daemonize`, I added: `this.global.set('run_as_root', true);` and saved the file. I when back to the home folder and did a `docker-compose down` and a `docker-compose up -d` to restart Peertube. This fixed the chat, but still left me without access to any of the new 4.2 features.

## Getting the new features working

This one was pretty quick to figure out. After looking at the [Docker page in the Peertube Github repo](https://github.com/Chocobozzz/PeerTube/blob/develop/support/doc/docker.md#upgrade), I noticed the upgrade instructions clearly mentioned to use the `-v` flag when bringing the docker-compose stack down, so as to "invalidate the static client files shared by `peertube` and `webserver` containers"

I'm not 100% sure what that actually means, but it sounds to me like its making sure that files serverd up by Peertube are not old cached files from older versions of Peertube. I gave it a shot:

```bash
docker-compose down -v
docker-compose up -d
```

... and that was it! Afterward all that was left to do to take full advantage of the new cool stuff in Peertube 4.2 was to go into the **Administration** menu, then **Configuration**, then **VOD Transcoding** and scroll to the bottom of the page to enable the in-place video editing features:

![Capture 2022-06-21T140125](Capture%202022-06-21T140125.png)




[^1]: Hey look! [bavatuesdays.com](https://bavatuesdays.com/upgrading-peertube-and-running-the-livechat-plugin/) is referenced in the issue as an example of another docker-based Peertube install.
