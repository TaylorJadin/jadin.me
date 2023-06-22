---
title: "To-do list for this site"
date: 2023-06-22T13:43:22-05:00
tags:
- meta
- reclaim
cover:
    relative: true
    image: cover.webp
---

I've got a whole list of improvements I want to make to this site coming off of Reclaim Open. 

This blog is a static site made with [hugo](https://gohugo.io/) and of course hosted on Reclaim Hosting. If you are curious about how it's made, I've done a stream and accompanying blog post about it:

[My Hugo setup and how this blog works](https://jadin.me/my-hugo-setup/)

## ☐ Pull in posts from Mastodon

This is a big one, and will take some design and javascript work. But I've started cooking something up already. I've got some ideas to bring in my Mastodon posts right on to the site, between posts. Visually, I'm inspired by [theverge.com's](https://theverge.com) redesign. I think I'd pull in a limited amount of posts dynamically on page load, and exclude replies and stuff like that for now. Just so quick thoughts get included on my home page.

I've already started working on this, but it might take me a bit. Also, I very well my change my mind before I ever get this working.

## ☐ Get rid of [disqus.com](https://disqus.com) comments and replace my site's comments system with something better

Disqus is free to use, but I don't like that an ad-tech product is a part of my blog's infrastructure. The cool thing here is because of the way hugo works, I should be able to keep it on all my old posts, while replacing it on all new posts.

So far I'm leaning towards going with [giscus](https://giscus.app), which uses GitHub's discussions feature for comments, which is cool because I already use GitHub for version control and syncing of the site. I also would like to somehow integrate Mastodon reply's into this site's comments.

Both of these comment system ideas are completely stolen from [Kathleen Fitzpatrick's blog](https://kfitz.info/)!

I'd rate the work required here at "medium-ish." This shouldn't be too hard, just need to set aside some time to work on it.

## ☐ Fix cover images
I added nice [lightboxes](https://www.w3schools.com/howto/howto_js_lightbox.asp) to all images on this site, except for cover images. I want to fix that, as well as add a slick integrated way to cover images, instead of putting text at the bottom of the post.

## ☐ About page

I should really make an about page where I can start collecting signature projects, presentations, and stuff like that.

This should take almost no time to start, but I likely won't get to it for a while for completely irrational reasons (i.e. I'm sort of bored by the idea at the moment, but it seems important)

## ☐ Something not really on the list... for now: ActivityPub integration

I've thought a lot about how to integrate this site with activitypub and fediverse stuff in some way, and so far, I just can't think of a way that would make sense. On the technical side, this is a static site, so what it could actually do would be limited, and on top of that, I've never loved the context collapse that pushing posts from a site out to social media (fediverse or otherwise) creates. I'd prefer to just write on this site, and then post a link on Mastodon afterward. 

But who knows, I could totally change my mind. 

---

Cover image: [danjo house work](https://www.flickr.com/photos/stonesoupinstitute/11073368704/in/photostream/) by Stone Soup Institute on Flickr