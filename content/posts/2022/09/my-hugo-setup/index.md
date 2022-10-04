---
title: "My Hugo setup and how this blog works"
date: 2022-09-29T12:08:24-0500
tags:
- meta
- reclaim
- tools
- opensource
cover:
    relative: true
    image: cover.webp
---

This week I did a stream to document how I use [hugo](https://gohugo.io/), the static site generator, for this blog that you're reading right now!

<iframe title="My Hugo setup" src="https://video.jadin.me/videos/embed/b43de357-9c77-47d9-ac99-01527410a906?start=7m33s" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups" width="560" height="315" frameborder="0"></iframe>

The point of the stream was to show how I use this tool, but all of this is really not a good starting point if you are looking to get started with hugo, or you just want to see how it works. For that, I'd recommend checking out the [hugo quick start documentation](https://gohugo.io/getting-started/quick-start/)!

The stream was about an hour and I talked a bit about why I use a static site generator for my blog, why specifically hugo, and how I use it on Reclaim Hosting. I go into more detail in the video, but basically I use GitHub to sync the files for my website, and then a script to SSH into the server and build my site. I also dove into the tools I use for this:

- [a GitHub repository](https://github.com/TaylorJadin/jadin.me/) for file syncing and backup
- a text editor for writing Markdown
  - I use [Visual Studio Code](https://code.visualstudio.com/) most often, and that what I demo in the video. I like it because it's a powerful text editor, but I can also manage files, use the terminal, and install extensions to give it more functionality.
  - Sometimes if I want a simpler editor to focus just on writing, I use [Typora](https://typora.io/). I didn't demo Typora, but the fact that my blog posts are written in Markdown means I can use just about any Text Editor, which I really dig. 
  - I also didn't demo this in the stream, but on the occasions that I find my self blogging from my phone or iPad, I use [Working Copy](https://workingcopy.app/), or sometimes [Taio](https://taio.app/)
- a few scripts that really speed up my workflow. They mainly fall into the categories of file-management shortcuts, or scripts that help me remember terminal commands
  - [post](https://github.com/TaylorJadin/jadin.me/blob/main/post) (make a new blog post)
  - [draft](https://github.com/TaylorJadin/jadin.me/blob/main/draft) (make a new draft blog post)
  - [journal](https://github.com/TaylorJadin/jadin.me/blob/main/journal) (make a new journal post)
  - [serve](https://github.com/TaylorJadin/jadin.me/blob/main/serve) (start the hugo server so I can preview the site)
  - [publish](https://github.com/TaylorJadin/jadin.me/blob/main/publish) (SSH into the server and call the build script)
  - [build](https://github.com/TaylorJadin/jadin.me/blob/main/build) (the script that updates the site, runs on the server and is called the publish script)

Other than the workflow stuff I also briefly touch on the fact that because I use Git for this, I also have a built in backup system that lets me revert changes if I need to. It also means the back-end of the site itself is public and anyone can look at the repository for it. I suppose I could have made it a private repository, but seeing as the site itself is public, why not make the back-end public too?

I mentioned it in the stream, but I'd also highly recommend [D'Arcy Norman's posts on hugo](https://darcynorman.net/tags/hugo/) as they have been helpful to me as I created a workflow for myself. 