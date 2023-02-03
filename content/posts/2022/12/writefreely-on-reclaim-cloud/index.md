---
title: Running WriteFreely on Reclaim Cloud
date: 2022-12-29
tags:
- reclaimcloud
- reclaim
- streamarchive
cover:
    relative: true
    image: cover.png
---

Today I did a quick stream attempting to get [WriteFreely](https://writefreely.org/) working on Reclaim Cloud. WriteFreely is an interesting tool that I wanted to play with, and I was able to get things working with some poking around and help from [Tim](https://blog.timowens.io/) who was watching and pointed out a `bind` setting in the `config.ini` file. More on that below. Things kick off at around 2:51.

<iframe title="Let's get WriteFreely running on Reclaim Cloud!" src="https://video.jadin.me/videos/embed/23cf50ba-5737-4182-96ea-befe794217dd?start=2m51s" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups" width="560" height="315" frameborder="0"></iframe>

Basically, I followed the instructions on their [install page](https://writefreely.org/start) with a few additions and caveats. I started with making a new environment in Reclaim Cloud with an Ubuntu 22.04 VPS as the application container.

I first made a folder inside `/var/www` to work from, then downloaded the latest release from github, extracted the tar.gz file and ran the configurator:

```bash
wget https://github.com/writefreely/writefreely/releases/download/v0.13.2/writefreely_0.13.2_linux_amd64.tar.gz
tar -xvf writefreely_0.13.2_linux_amd64.tar.gz
./writefreely config start
```

When going through the configurator thing I had it set up a "production - standalone" instance, using sqlite, with "insecure - port 80" for the https settings. I also set the public url to the Reclaim Cloud environment url: http://writefreely.uk.reclaim.cloud

Then I ran the command to generate the keys it needed:

```bash
./writefreely keys generate
```

Then I had to edit the `config.ini` file to set it to listen on all network interfaces by changing the line that starts with `bind`:
```ini
bind = 0.0.0.0
```

That took a while to figure out, as until I changed that, WriteFreely wasn't publiclly accessible.

Then I used the instructions on the page to make a service for Ubuntu 15.04 or later. Mine looked like this:

```
[Unit]
Description=WriteFreely Instance
After=syslog.target network.target
# If MySQL is running on the same machine, uncomment the following 
# line to use it, instead. 
#After=syslog.target network.target mysql.service

[Service]
Type=simple
StandardOutput=syslog
StandardError=syslog
WorkingDirectory=/var/www/writefreely.uk.reclaim.cloud/writefreely
ExecStart=/var/www/writefreely.uk.reclaim.cloud/writefreely/writefreely
Restart=always

[Install]
WantedBy=multi-user.target
```

Finally, I started the service:
```bash
systemctl start writefreely
```

Once that worked, I added an nginx load balancer, and turned on Auto SSL to get things loading over HTTPS!

Overall, it was a success, except I wasn't able to get the federation features working properly. I suspect this is because I was using the shared load balancer on reclaim cloud instead of a dedicated IP. I will also likely need to play with the nginx config. More on that later, hopefully!