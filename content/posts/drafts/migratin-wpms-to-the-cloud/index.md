---
title: Migrating WPMS setups to the cloud
date: 2023-10-03
tags:
  - reclaim
  - reclaimcloud
  - wordpress
  - streamarchive
cover:
  relative: true
  image:
---

A couple weeks back I did a stream with Amanda and Pilot where I showed off what I've been learning about quickly and efficiently moving WordPress Multisite and [Commons in a Box](https://commonsinabox.org/) setups to Reclaim Cloud. I've done a few CBOX Openlab migrations to put them on Reclaim Cloud recently, so I wanted to document what I've been learning.

<iframe title="Migrating WPMS setups to the cloud!" width="560" height="315" src="https://archive.reclaim.tv/videos/embed/31b5bbd4-8a59-4637-add2-053ca8fb0dc2" frameborder="0" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups"></iframe>

I go into detail in the stream, but here are the basic steps:

## Generate and install SSH keys
This will make things much easier when shuttling files around. I use typically use this article as a reference:
[Generating and using SSH key pairs](https://support.reclaimhosting.com/hc/en-us/articles/8421003621015-Generating-and-using-SSH-key-pairs)

## Move over the database
First I need to dump the databse of the site. From the cPanel acccount that hosted it I ran this command to dump the database and gzip it:

```bash
mysqldump -u MYSQLUSER -p DATABASE --quick --skip-lock-tables | gzip > openlab.sql.gz
```

Doing this from the terminal rather than phpmyadmin is faster and way more reliable for larger databases like this. Its basically mandatory for WordPress Multisite in my experience.