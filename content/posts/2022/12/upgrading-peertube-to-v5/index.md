---
title: Upgrading Peertube to 5.0!
date: 2022-12-22
tags:
- peertube
- cloud
- reclaim
---

Here are some notes I made on how to upgrade Peertube to version 5.0. Version 5 came with some big changes, and required some a new config for nginx, as well as a required setting in a *new to me* production.yaml file. Here are some quick notes if you are having trouble upgrading to version 5, and you are using a docker-compose based setup. There were some notes in the [GitHub release](https://github.com/Chocobozzz/PeerTube/releases/tag/v5.0.0) for this new version that informed my notes below, but it did take me a little figuring and experimentation to make sense of all of it. 

Before getting started, check where your docker-compose file is for Peertube. Looking at the [Peertube GitHub](https://github.com/Chocobozzz/PeerTube), you'll see references to `/var/www/peertube-docker` but if you used our reclaim cloud installer your files are in `/root`. I'll assume your Peertube's docker-compose.yml is in `/root` in the following commands, but adjust as necessary.

First, we need to pull the new containers:

```bash
cd /root
docker-compose pull
```

Next we need to use get the new config file for the nginx container from the Peertube github.

```bash
cd /root/docker-volume/nginx
rm peertube
wget https://raw.githubusercontent.com/Chocobozzz/PeerTube/develop/support/nginx/peertube
```