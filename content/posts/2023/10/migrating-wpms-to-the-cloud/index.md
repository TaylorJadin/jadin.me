---
title: Migrating WordPress Multisite setups to the cloud!
date: 2023-10-05
tags:
  - reclaim
  - reclaimcloud
  - reclaimpress
  - wordpress
  - streamarchive
cover:
  relative: true
  image: geese.jpg
---

A couple of weeks back I did a stream with Amanda and Pilot where I showed off what I've been learning about moving WordPress Multisite and [Commons in a Box](https://commonsinabox.org/) setups to Reclaim Cloud. I've done a few CBOX Openlab migrations, most recently for [SUNY Oneonta](https://openlab.oneonta.edu/) and [University of New Haven](https://unewhavendh.org/), so I wanted to document what I've been learning. The great thing about CBOX Classic and CBOX Openlab is that they really are just WordPress Multisite, and so not too much special was necessary above and beyond moving any other Multisite.

<iframe title="Migrating WPMS setups to the cloud!" width="100%" height="405" src="https://archive.reclaim.tv/videos/embed/31b5bbd4-8a59-4637-add2-053ca8fb0dc2" frameborder="0" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups"></iframe>

This is not using a plugin like Updraft Plus or anything like that, as that is usually way slower and can be problematic for large or complex sites. Doing this via command line tools mostly manually means we can transfer files directly between servers using rsync, saving us lots of time. I go into detail in the stream, but the steps are also below. For simplicity, I'm going to refer to the new site on the cloud as the "destination" site and the old site on Shared Hosting as the "source."

### Install a fresh copy of WP on Reclaim Cloud
Use the WordPress standalone kit, and enable Multisite.

### Make copies of the `wp-config.php` and `.htaccess` files for both the destination and source sites
This is handy for database information in particular. There are also many cases where I need to fix .htaccess rules after migration, like removing references to different PHP versions, or preserving redirect rules etc. Either download a copy to your computer for safe keeping or copy and paste the contents somewhere.

### Generate and install SSH keys
This will make things much easier when shuttling files around. I typically use this article as a reference:
[Generating and using SSH key pairs](https://support.reclaimhosting.com/hc/en-us/articles/8421003621015-Generating-and-using-SSH-key-pairs)

After generating a keypair on the destination site, I add the public key to the `~/.ssh/authorized_keys` on the source.

### Move the database over
First I need to dump the database of the site. From the source, I run this command to dump the database and gzip it:

```bash
mysqldump -u MYSQLUSER -p DATABASE --quick --skip-lock-tables | gzip > db.sql.gz
```

Doing this from the terminal rather than PHPMyAdmin is faster and way more reliable for larger databases. On the stream I had trouble with doing this via the terminal, but it was becuase I forgot the `--no-tablespaces` option.[^1]

[^1]: ['Access denied; you need (at least one of) the PROCESS privilege(s) for this operation' when trying to dump tablespaces - Stack Exchange](https://dba.stackexchange.com/questions/271981/access-denied-you-need-at-least-one-of-the-process-privileges-for-this-ope)

Then I will upload the dumped databse to the destination site, typically just with the file manager in Reclaim Cloud, but if its a really large database I'll SFTP or `rsync` it. Then its time to restore the database:

```bash
# Unzip it
gzip -d db.sql.gz
# Restore it
mysql -u DB_USER -p DB_NAME < db.sql
```

For the restore command I'll use the database name, username, and password from the destination's `wp-config.php` file.

### Rsync time!
Rsync is one of those tools that can be scary at first, but learning it pays dividends. We're going to want to run the rsync command from the destination server, as thats where we generated our keys. We'd replace `USER` with the cPanel username on shared hosting, `DOMAIN.COM` with the domain name, and `/PATH/TO/SITE/` with the path of the source site on the server. `/var/www/webroot/ROOT/` is always going to be the path to the webroot on Reclaim Cloud.

```bash
rsync -ahzP USER@DOMAIN.COM:/PATH/TO/SITE/ /var/www/webroot/ROOT/
```

### Fix permissions
Sometimes permissions problems can pop up after rsyncing stuff between different servers, as rsync will preserve ownership and permissions as much as it can. As a precaution, I always fix permissions on the destination with these commands after copying files:

```bash
cd /var/www/webroot/ROOT
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
```

### Fix up `.htaccess` and `wp-config.php` files on the destination
We'll need to replace the database information that came over in `wp-config.php` with the proper stuff for the destination site in Reclaim Cloud. We may also need to any specific PHP paths referenced in `.htaccess` if thats in there. This why we made copies of both sets of these files near the start!

### Fix upload path in the database
The upload path is often hardcoded into the database in the `wp_options` table under `upload_path`. We'll need to update this to the proper location for Reclaim Cloud, which is `/var/www/webroot/ROOT/wp-content/uploads`.

### Preview and point DNS!

You are ready to see how the migration went! Before pointing DNS for real, I'd suggest using your hosts file to preview the new site.
[Pointing localhost File to Preview Site – Reclaim Hosting](https://support.reclaimhosting.com/hc/en-us/articles/1500011279141-Pointing-localhost-File-to-Preview-Site#step-2-open-the-windows-hosts-file)

When you are ready, you can change your A record for the domain to point to the public IP in Reclaim Cloud. You'll also probably want to issue a Let's Encrypt cert.

[Installing SSL Certificates on Reclaim Cloud using the Let's Encrypt Add-on – Reclaim Hosting](https://support.reclaimhosting.com/hc/en-us/articles/4404869581079-Installing-SSL-Certificates-on-Reclaim-Cloud-using-the-Let-s-Encrypt-Add-on)

### (Optional) If you are changing domain names

If we are moving a site from one domain name to another, say from `oldurl.com` to `newurl.com`, we'll need to do a find and replace in the database for things to load properly. The `wp` cli tool is super handy for this:

```bash
wp search-replace --all-tables https://oldurl.com https://newurl.com --dry-run
wp search-replace --all-tables http://oldurl.com http://newurl.com --dry-run
```

Run the commands first with the `--dry-run` flag as shown above to test things out, then do it for real by removing the `--dry-run` flag.

You will also need to update `wp-config.php` to reference the new domain name.