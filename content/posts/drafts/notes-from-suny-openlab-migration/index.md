---
title: Some notes from migrating openlab.oneonta.edu to Reclaim Cloud
date: 2023-08-18T09:57:17.869244-05:00
tags:
- reclaim
- reclaimcloud
- wordpress
cover:
  relative: true
  image: 
---

This is a post to serve as a quick place to put my notes from a recent migration I did for [Ed Beck](https://ed-beck.com/) and the folks at SUNY Oneonta. They had a [CBOX Openlab](https://commonsinabox.org/cbox-openlab-overview)site that was running inside a cPanel account on [their DoOO](https://sunycreate.cloud/) and they wanted to migrate it out to Reclaim Cloud to make sure the Openlab site remained fast as they had more people using it. It used to be located at [oneonta.sunycreate.cloud](https://oneonta.sunycreate.cloud/) but as part of the migration it was moved to [openlab.oneonta.edu](https://openlab.oneonta.edu/). Ultimately, CBOX wasn't much a factor here this ended up being a straight ahead WordPress Multisite migration from cPanel to Reclaim Cloud, with a domain name change thrown in there.

Here are my notes:

## Generate and install SSH keys
This will make things much easier when shuttling files around. I use typically use this article as a reference:
[Generating and using SSH key pairs](https://support.reclaimhosting.com/hc/en-us/articles/8421003621015-Generating-and-using-SSH-key-pairs)

## Move over the database
First I need to dump the databse of the site. From the cPanel acccount that hosted it I ran this command to dump the database and gzip it:

```bash
mysqldump -u MYSQLUSER -p DATABASE --quick --skip-lock-tables | gzip > openlab.sql.gz
```

Doing this from the terminal rather than phpmyadmin is faster and way more reliable for larger databases like this. Its basically mandatory for WordPress Multisite in my experience.