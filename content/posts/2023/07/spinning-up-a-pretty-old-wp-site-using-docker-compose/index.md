---
title: "Spinning Up a Pretty Old WordPress Site Using Docker Compose"
date: 2023-07-12T15:47:42-05:00
tags:
- reclaim
- docker
cover:
    relative: true
    image: 
---

For reasons, I needed to spin up a very old WordPress site using Docker today. I'm writing this blog post, mostly just to jot down the compose file so I have it handy in the future.

Digging through the [oldest tags for the `wordpress` image on DockerHub](https://hub.docker.com/_/wordpress/tags?page=123) it looked like 4.1 was the oldest version available so I went with it. For the database I went with the last version of mysql version 5. Then I fired up a docker environment from the Reclaim Cloud marketplace.

![](Pasted%20image%2020230712155342.png)

Next, I fired up the config panel (file manager thing), and made a folder to work in at `/root/wp-41` and made a `docker-compose.yml` file. Here's what I put in that file:

```yaml
version: "3"

services:
  wordpress:
    image: wordpress:4.1
    restart: unless-stopped
    ports:
      - 80:80
    environment:
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DB_USER: wp
      WORDPRESS_DB_PASSWORD: PUTAPASSWORDHERE
      WORDPRESS_DB_NAME: wordpress_db
    volumes:
      - ./public_html:/var/www/html
  mysql:
    image: mysql:5.7.42
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: wordpress_db
      MYSQL_USER: wp
      MYSQL_PASSWORD: PUTAPASSWORDHERE
      MYSQL_ROOT_PASSWORD: PUTANOTHERPASSWORDHERE
    volumes:
      - ./db:/var/lib/mysql
```

Then I opened a terminal, and started things up, as well as tailed the logs. I ultimately had to make some tweaks to land on the above file, so looking at the logs is helpful.

```bash
cd wp-41/
docker-compose up -d && docker-compose logs -f
```

Bam, WP 4.1