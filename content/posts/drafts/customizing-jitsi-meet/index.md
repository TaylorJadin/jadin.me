---
title: Customizing Jitsi Meet
date:
tags:
- reclaim
- reclaim cloud
- docker
cover:
    relative: true
    image: 
---
I've wanted to look into how to customize Jitsi Meet installations that we have installed on Reclaim Cloud. The trick with this is A, Jitsi is a pretty complicated application, and B, our Jitsi installer on Reclaim Cloud makes a docker-compose based installations. This means that updating Jitsi over time is significantly easier, but it does mean that figuring out where you might need to go to change certain things can be difficult. 

By default, there is a hidden directory that gets created in the user account that Jitsi is running from, `/root/.jitsi-meet-cfg`

This directory is where jitsi stores recordings and a ton of other information. I did some digging, 
`/root/.jitsi-meet-cfg/web/interface_config.js`

change APP_NAME
line 155 change SHOW_BRAND_WATERMARK: false,
