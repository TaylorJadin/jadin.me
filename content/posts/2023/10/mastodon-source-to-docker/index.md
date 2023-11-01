---
title: Migrating Mastodon from a Source Install to a Dockerized Install
date: 2023-10-28T13:04:23.014963700-05:00
tags:
  - reclaim
  - reclaimcloud
  - docker
cover:
  relative: true
  image:
---
[Jim beat me to blogging it](https://bavatuesdays.com/containerizing-mastodon-on-reclaim-cloud/), but on Friday he and I jumped on a stream and migrated a test instance of Mastodon he has that he [installed the manual way](https://docs.joinmastodon.org/admin/install/), over to a new dockerized install using my [1-click installer on Reclaim Cloud](https://support.reclaimhosting.com/hc/en-us/articles/11874719336087-Running-Mastodon-on-Reclaim-Cloud). 

<iframe title="Migrating a Mastodon source install into a Dockerized install!" width="100%" height="315" src="https://archive.reclaim.tv/videos/embed/d20860dc-24f6-42d7-80c2-cc6002f43eed" frameborder="0" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups"></iframe>

Things went super smoothly and this should make future upgrades and maintenance super painless. Because the server uses an S3 bucket for its images, really all we needed to do was dump and restore the database, and then fill out the `.env` file that had settings for Mail and S3. I found most of what I needed to know about the database side e of things from this doc:
[Migrating to a new machine - Mastodon documentation](https://docs.joinmastodon.org/admin/migrating/)

And here are the notes I was taking while we were on stream:\

## Notes

### Update .env file
Look at the install's `env.production` file and port over any necessary settings in to `/root/mastodon/.env`

### dump the database
```bash
su mastodon
pg_dump -Fc mastodon_production -f backup.dump
```

### upload backup.dump to new mastodon install
Just use the file manager if its small, otherwise rsync or sftp.

### copy file into db container
```bash
docker cp backup.dump postgres:/backup.dump
```

### get a shell inside the database container
```bash
docker exec -it postgres bash
```

### make a database
```bash
createdb -U mastoson -T template0 mastodon_production
```
`-U mastodon` will tell postgres to use the `mastodon` role, instead of the `root` role.

### restore the database
```bash
pg_restore -Fc -U mastodon -n public --no-owner --role=mastodon -d mastodon_production /backup.dump
```

### exit out of postgres container and restart all the containers
```bash
exit
docker-compose down && docker-compose up -d && docker-compose logs -f
```
Things should be working! Now all we need to do is drop the extra db.

### go back in to the postgres container and drop db
We don't need the original database that the installer made, which was called `mastodon` anymore.
```bash
docker exec -it postgres bash
dropdb -U mastodon mastodon
```
