---
title: Setting up Peertube to use Backblaze B2 storage
date: 2022-12-22T11:12:50-0600
tags:
- peertube
- cloud
- reclaim
cover:
    relative: true
    image: 
---

I've been busy with Peertube stuff lately. After getting my own instance at [video.jadin.me](https://video.jadin.me) upgraded to 5.0, I also wanted to set up object storage so I could utilize Amazon S3 or the alternatives. In this case I wanted to use Backblaze B2, as I'm already using Backblaze's Personal backup for backing up computers in my home, and generally a fan of the simplicity of B2 compared to doing stuff in the AWS dashboard. Plus, it's [so much cheaper](https://www.backblaze.com/b2/cloud-storage-pricing.html)!

## The Backblaze part

The first thing to do was to get a B2 bucket set up. I'm not going to go into much detail, as this is relatively simple once you have a Backblaze account. I named my bucket "video-jadin-me".

![](Pasted%20image%2020221222115158.png)

Once the bucket was made, I went to the **App Keys** section to generate credentials for Peertube to use, then made note of them for later.

I also went to **Bucket Settings** to make sure uploaded files were publicly accessible (they'll still be behind long obscure URLs though). I'm pretty sure that with Peertube 5.0 this is actually not necessary as Peertube will proxy the video traffic, meaning that I could actually keep this set to private, but URL obscurity is more than secure enough for my use case here.

![](Capture%202022-12-22T115640.png)

Next, I went to **CORS Rules** and set **Share everything in this bucket with every origin**. This is necessary for Peertube to be able to play the actual video files, but if I was concerned about this security more, I could have likely locked it down to the **Share everything in this bucket with this one origin** and then entered **video.jadin.me**. Who knows, maybe I'll revisit this and the public/private settings later on now that I know it all works.

![](Pasted%20image%2020221222122255.png)

Finally, I also adjusted the **Lifecycle Settings** to keep 30 days worth of backup copies of files, in case I ever deleted something on accident. This is slick because of the way that B2 (and other S3 compatible storage works) it only keeps changed or deleted files for 30 days, not a separate backup of everything, saving you space and therefore money!

It's awesome that all of this was easy to do, without even having to resort to documentation. Also, I didn't have to jump to like 36 sections of the Dashboard, nor write any JSON for configuration. Take that, AWS!

## The Peertube part

Figuring out how to set it up on Peertube took some experimentation. It's half documented here:

[Remote storage (S3) - docs.joinpeertube.org](https://docs.joinpeertube.org/admin-remote-storage?id=remote-storage-s3)[^1]

Reading that then checking out the `production.yaml.example` [file in Github](https://github.com/Chocobozzz/PeerTube/blob/develop/config/production.yaml.example) gave me a clue.
[^1]: It's cool to see they use [Docsify](https://docsify.js.org) for their documentation! I'm a big fan of Docsify after using it for a project recently.

After trying a few different things, I finally got it working.  Here's the **object_storage** section of my Peertube's `production.yaml`, which is located at `/root/docker-compose/config/production.yaml`

```yaml
object_storage:
  enabled: true
  endpoint: 's3.us-west-002.backblazeb2.com'
  upload_acl:
    public: 'public-read'
    private: 'private'
  videos:
    bucket_name: 'video-jadin-me'
    prefix: 'videos/'
  streaming_playlists:
    bucket_name: 'video-jadin-me'
    prefix: 'streaming-playlists/'
  credentials:
    access_key_id: 'keyID from Backblaze'
    secret_access_key: 'applicationKey from Backblaze'
```

You'll want to fill in the fill in the `access_key_id` and `secret_access_key` fields, as well as `endpoint` and `bucket_name` to match with your B2 bucket.

Then I restarted Peertube for good measure[^2], and uploaded a tiny test video! Once it uploaded and transcoded, I checked my Backblaze account to see that the file wound up in the right place.

[^2]: `docker-compose down && docker-compose up -d`

## Moving existing videos to B2
I checked out the [Peertube docs](https://docs.joinpeertube.org/maintain-tools?id=create-move-video-storage-jobjs) again to see how I could move existing videos into B2. I ended using the commands verbatim. First I moved a few files, one at a time:
```bash
docker-compose exec -u peertube peertube npm run create-move-video-storage-job -- --to-object-storage -v [videoUUID]
```

Note that the videoUUID is not just the last part of the URL on the watch page, like on YouTube. Personally, I like to find a video's UUID by going to the stats page for the video and looking at the URL there, but there may be better ways.

![](Capture%202022-12-22T121853.png)

Once I did a few and they seemed to work, I ran the command to move all of the videos to B2:
```bash
docker-compose exec -u peertube peertube npm run create-move-video-storage-job -- --to-object-storage --all-videos
```

I used `iftop` to watch the traffic out to Backblaze as there isn't really a good progress indicator anywhere else:
![](Pasted%20image%2020221222122309.png)

You can also see the Jobs get created in the Peertube web interface by going to **Administration > System > Jobs**
![](Pasted%20image%2020221222122414.png)

Now I'm all set with just shy of 200GB of videos stored in Backblaze!