publish:
	ssh jadinme@jadin.me 'bash /home/jadinme/jadin.me/build'

journal:
	hugo new --kind journal posts/$(date +"%Y")/$(date +"%m")/$(date +%Y-%m-%d)

draft-journal:
	hugo new --kind journal posts/drafts/$(date +%Y-%m-%d)

serve: 
	if [[ `uname -n` == "taylor-compy" ]]; then
	    hugo.exe serve
	else
	    hugo serve
	fi

serve-drafts:
	if [[ `uname -n` == "taylor-compy" ]]; then
	    hugo.exe serve --buildDrafts --buildFuture
	else
	    hugo serve --buildDrafts --buildFuture
	fi

build:
	hugoDir='/home/jadinme/jadin.me'
	siteDir='/home/jadinme/public_html'

	if ! [ -d $hugoDir ]
	then
		echo "$hugoDir does not exist. Exiting."
		exit
	fi

	if ! [ -d $siteDir ]
	then
		echo "$siteDir does not exist. Exiting."
		exit
	fi

	cd $hugoDir && git pull && hugo -d $siteDir