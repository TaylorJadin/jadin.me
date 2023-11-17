---
title: A one-liner for using ffmpeg to stream a video file over RTMP
date: 2023-11-01T16:58:28.076773-05:00
tags:
- cli
cover:
  relative: true
  image: 
---

I was hacking up Reclaim TV a bunch the last few days to integrate our Discord chat onto the page and this came in handy to quickly start streaming a video file to Owncast for testing purposes:

```bash
ffmpeg -re -i MOVIE.mp4  -c:v libx264 -preset veryfast -c:a aac -ac 2 -f flv 'rtmp://STREAMURL/STREAMKEY'
```

I needed to stream to Reclaim TV so I could test the chat functionality, which only works when you are live, so I decided to stream Beatlejuice which I have a rip of on my server, so the command looked kinda like this:

```bash
 ffmpeg -re -i /Volumes/media/Movies/Beetlejuice\ \(1988\)/Beetlejuice\ \(1988\).mp4  -c:v libx264 -preset veryfast -c:a aac -ac 2 -f flv 'rtmp://reclaim.tv:1935/live/SUPER_SECRET_STREAM_KEY'
 ```

It was handy to be able to just fire that up quickly without having to mess around with OBS, Streamyard or anything else.