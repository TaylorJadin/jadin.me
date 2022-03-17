---
title: Customizing the look of Peertube
date: 2022-03-17
tags:
- reclaim cloud
- css
- peertube
cover:
  relative: true
  image: peertubescreenshot.png
---

PeerTube is a really nice self-hostable YouTube alternative that [Jim Groom](https://bavatuesdays.com) has been using for a bit, and I wanted to spin up my own install at [video.jadin.me](https://video.jadin.me) and theme it a bit to fit in with this blog site. 

The first thing I did was install the dark theme, which I thought would more closely match my blog site as a starting point. You can do this from **Administration > Plugins/Themes**. I grabbed the official dark theme:
![screenshot of themes in the peertube admin interface](peertubethemes.png)

After installing it, you will need to enabled it from the **Administration > Configuration > Basic** page. 

What I really wanted to do was change the accent colors in the interface, as well as hide some buttons that I feel like are unnecessary with the way I use Peertube[^1]. Custom CSS can be entered on the **Administration > Configuration > Advanced** page. I wanted to simply post my CSS customizations here in case anyone finds them to be useful! Note that these are most likely also specific to the dark theme I am using, so they may require tweaking if you are using a different theme. 

```css
/* Change colors */
body#custom-css {
  --mainColor: #f92672;
  --mainColorLighter: #e5789b;
  --mainColorLightest: #dbdbdb;
  --mainHoverColor: #9f1f49;
  --secondaryColor: #98BE47;
}

/* Hide the publish button if you are not logged in */
#custom-css > my-app > div.peertube-container.user-not-logged-in > div.header > div.header-right > my-header > a {
  display: none;
}

/* Fix the background of the playlist info section in the dark theme */
.playlist-info {
  background-color: transparent !important;
}

/* Hide various other things */
.login-buttons-block, /* login buttons, I just login by going to /admin */
.block-title, /* hide the "on video.jadin.me" thing */
.icon-logo, /* hide the logo at the top left */
div.active-filter:nth-child(2), /* hide the sensitive content filter button*/
.on-instance > a:nth-child(2) /* hide the trending button */
{
  display: none !important;
}
```

[^1]: For instance, the sensitive content filter. I don't have any of that on my PeerTube instance, so that button is unnecessary