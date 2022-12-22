---
title: Upgrading Peertube to 5.0!
date: 2022-12-22T11:12:45-0600
tags:
- peertube
- cloud
- reclaim
---
Here are some notes I made on how I upgraded Peertube to version 5.0. Version 5 came with some big changes, and required some a new config for nginx, as well as a required setting in a *new to me* production.yaml file. Here are some quick notes if you are having trouble upgrading to version 5, and you are using a docker-compose based setup. There were some notes in the [GitHub release](https://github.com/Chocobozzz/PeerTube/releases/tag/v5.0.0) for this new version that informed my notes below, but it did take me a little figuring and experimentation to make sense of all of it. 

Before getting started, check where your docker-compose file is for Peertube. Looking at the [Peertube GitHub](https://github.com/Chocobozzz/PeerTube), you'll see references to `/var/www/peertube-docker` but if you used our reclaim cloud installer your files are in `/root`. I'll assume your Peertube's docker-compose.yml is in `/root` in the following commands, but adjust as necessary.

First, we need to pull the new containers:

```bash
cd /root
docker-compose pull
```

Next, we need to use get the new config file for the nginx container from the Peertube GitHub.

```bash
cd /root/docker-volume/nginx
rm peertube
wget https://raw.githubusercontent.com/Chocobozzz/PeerTube/develop/support/nginx/peertube
```

We also need to generate a secret, and put it in the `production.yaml` [configuration file](https://github.com/Chocobozzz/PeerTube/blob/v5.0.0/config/production.yaml.example#L14). I didn't have one of these, so I made a blank one to start. 

```bash
cd /root/docker-volume/config
touch production.yaml
```

We'll need to generate a key, which we can do from the command line with this command:
```bash
openssl rand -hex 32
```
Copy that somewhere, as we'll need it in a second.

Next, we'll edit our `production.yaml` file to include a new secret section. You'll also want to paste in your key.
```bash
vim /root/docker-volume/config/production.yaml
```

Mine now looks something like this:
```yaml
secrets:
  # Generate one using `openssl rand -hex 32`
  peertube: 'your-generated-key-goes-between-these-quotes'
```

We've got most of the hard stuff done. Now we need to restart Peertube:
```bash
cd /root
docker-compose down -v
docker-compose up -d
```

If Peertube doesn't come back up properly, tail the logs:
```bash
docker-compose logs -f 
```

Finally, when things are all set, we have to run a migration script as Peertube has changed where it stores private video files:
```bash
cd /root
docker-compose exec -u peertube peertube node dist/scripts/migrations/peertube-5.0.js
```