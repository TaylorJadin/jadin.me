---
title: "Flattening sites to HTML with HTTrack"
date: 2022-10-24T13:39:30-05:00
tags:
- streamarchive
- reclaim
- sitearchiving
cover:
    relative: true
    image: 
---

Two weeks ago, I did a stream on HTML flattening with a tool called [HTTrack](https://www.httrack.com/). I've been wanting to show this off for a while as I think it makes the processing of flattening a site relatively easy, plus it works across macOS, Linux, and Windows. I've been a little behind on blogging this one, as I didn't have the video available on [video.jadin.me](https://video.jadin.me) until recently. This video was my test case for setting up my Peertube instance to store its videos on [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html), which is a lot like Amazon's S3 storage, but even cheaper for many use cases. I think I got that all working properly now, so the video should be up for good! I plan to also write about what I learned setting up Peertube with Backblaze B2 in the near future too.

<center>
<iframe title="Flattening sites to HTML with HTTrack" src="https://video.jadin.me/videos/embed/cd4d150e-ead8-4855-ab9a-698605f4df6f?start=6m" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups" width="560" height="315" frameborder="0"></iframe>
</center>

I didn't have time to demo this on the stream, but I mentioned early on that HTTrack and most other flattening tools weren't able to properly archive my own site while keeping the CSS linked properly. Here's how it would look when I would try:

![the jadin.me homepage but with no CSS](Capture%202022-10-24T135248.webp)

A couple of days after this stream, I ended up digging into this further and found that it is because the theme I use for my site links CSS stylesheets in using [Subresource integrity](https://www.w3.org/TR/SRI/), basically a checksum to make sure the CSS is delivered to the browser the way it was intended and from the right domain name. 

Basically, it's the `crossorigin` and `integrity` attributes in the html below
```html
<link crossorigin="anonymous" href="/assets/css/stylesheet.min.f15c5f92ccf596b9ae53126ff477060bbea3aa7a2fc6a1af48f0e89a2cf6148d.css" integrity="sha256-8Vxfksz1lrmuUxJv9HcGC76jqnovxqGvSPDomiz2FI0=" rel="preload stylesheet" as="style">
```

I ended up writing a quick one-liner using `sed` and `find` to find all of those subresource integrity rules and remove them from the flattened HTML:
```bash
find . -name "*.html" -exec sed -i -E -e 's/integrity="[^"]+"//g' -e 's/crossorigin="[^"]+"//g' {} \;
```

After pulling the subresource integrity stuff out of the archived HTML, its fixed!

![the jadin.me homepage flattened to html properly!](Capture%202022-10-24T135714.webp)

Now that this is part of my script, that one little wrinkle is something I shouldn't have to worry about. 