---
title: "A Stream Deck button to Start or Stop OBS Virtual Camera"
date: 2023-12-07T12:11:37-06:00
tags:
- setup
- obs
cover:
    relative: true
    image: 
---

This is a quick follow-up on a [post from two years ago](https://jadin.me/starting-obs-with-streamdeck/) where I talked about making a button on my Stream Deck that automatically launched OBS and started the Virtual Camera feature. I tend to use the Virtual Camera feature quite a bit, particularly in Slack Huddles, which don't display my camera properly[^1].

Since then, I wanted to make the button a toggle, so if OBS was already running it would quit. Also, on the most recent version of OBS, the `--args --startvirtualcam` launch parameter no longer works properly for me, so I needed a new solution.

I found a [comment on a GitHub Gist where someone set a hotkey in OBS to start and stop the Virtual Camera feature](https://gist.github.com/iamkirkbater/ba6278d0ac6d695cb8c6c5fc309ba210?permalink_comment_id=4115758#gistcomment-4115758) and used that to automate things, so I ran with that idea.

Step one was to set up the hotkey:

![OBS's Settings page under hotkeys](<Capture 2023-12-07 12.16.24@2x.png>)

Step two was to adapt the AppleScript that I found in that GitHub Gist. Basically this will first check if OBS is running or not. If isn't, it will launch OBS, wait a half second, then hit they F5 key to start Virtual Camera. After that it hides the window. If OBS is already running, it will unhide the window, wait a half second, hit F5 to stop Virtual Camera, then Quit OBS.

```applescript
if application "OBS" is running then
	tell application "System Events"
		tell process "OBS"
			set visible to true
			set frontmost to true
			delay .5
			key code 96 -- f5
		end tell
	end tell
	delay 1
	tell application "OBS" to quit
else
	tell application "OBS" to activate
	tell application "System Events"
		tell process "OBS"
			set frontmost to true
			delay .5
			key code 96 -- f5
			delay .1
			set visible to false
		end tell
	end tell
end if
```

I saved this to a `.applescript` file so that I could run that using my Stream Deck.

Step 3 was making the Stream Deck button to launch that script, using an "Open" action. I also gave it a nice icon:

![the stream deck configuration software with an OBS logo on one of the buttons](<Capture 2023-12-07 12.23.15@2x.png>)

Voila! It works perfectly and is super handy!

[^1]: Seriously it's amazing to me that Slack doesn't support HD camera feeds.
