#!/bin/bash

# bash_aliases

## Allow aliases to be with sudo
alias sudo="sudo "

## Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"


## Git

# Open any files marked as “modified” in your default editor.
alias changed='open `git status --porcelain | sed -ne "s/^ M //p"`'

# Create SVN-style patch
alias svnpatch="git diff master... --no-prefix > "


## “What was that alias again?” Meta!
alias aliases="c ~/.dotfiles/bash/bash_aliases"


## IP addresses
alias ip='IP=`dig +short myip.opendns.com @resolver1.opendns.com`; growlnotify -s -a terminal -t "IP Address" -m "${IP}"'
alias lip='IP=`ipconfig getifaddr en0`; growlnotify -s -a terminal -t "Local IP" -m "${IP}"'


## Copy my public key to the pasteboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"


## Flush DNS cache
alias flushdns="sudo discoveryutil mdnsflushcache && sudo killall -HUP mDNSResponder && sudo dscacheutil -flushcache"


## Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"


## Show/hide hidden files in Finder
alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"


## Hide/show all desktop icons (useful when presenting)
alias showdeskicons="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedeskicons="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"


## ssh
alias a="ssh aquaman"
alias b="ssh batman"


## sshfs
alias mounta="umount /Volumes/aquaman ; mkdir -pv /Volumes/aquaman ; sshfs -C -p 22 dnewton@knowledgetranslation.ca:/ /Volumes/aquaman -o defer_permissions,volname=aquaman -o local"
alias mountb="umount /Volumes/batman ; mkdir -pv /Volumes/batman ; sshfs -C -p 22 dnewton@dev.knowledgetranslation.ca:/ /Volumes/batman -o defer_permissions,volname=batman -o local"


## packager managers

alias packup="sudo softwareupdate --install --all ; sudo gem update ; sudo gem cleanup ; sudo gem update ; bundle update ; bundler update ; bundler install ; brew update ; brew upgrade --all ; brew uninstall --force node ; brew install node ; brew cleanup ; brew prune ; npm install -g npm@latest ; npm update -g ; pip install --upgrade pip setuptools ; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U ; brew linkapps python ; pip3 install --upgrade pip setuptools ; pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U ; brew linkapps python3 ; open /Applications/App\ Store.app"

alias packupLocal="sudo softwareupdate --install --all ; sudo gem update ; sudo gem cleanup ; sudo gem update ; bundle update ; bundler update ; bundler install ; brew update ; brew upgrade --all; brew uninstall --force node ; brew install node ; brew cleanup ; brew prune && npm install -g npm@latest ; npm install npm@latest ; npm update -g ; npm update ; pip install --upgrade pip setuptools ; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U ; brew linkapps python ; pip3 install --upgrade pip setuptools ; pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U ; brew linkapps python3 ; composer self-update ; composer update ; bower update ; open /Applications/App\ Store.app"


## sql
alias sql="mysql -u root -p"
alias sqld="mysqldump -u root -p"


## SMS
sendtext () { curl http://textbelt.com/text -d number=6476696398 -d "message=$1";echo message sent; }


## ImageMagick

smartresize() {
	mogrify -path $3 -filter Triangle -define filter:support=2.0 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
        if [ $4 -eq "1" ]; then
		RM="0"
		if [ ! -f ./i_o.yml ]; then
			RM="1"
			echo "verbose: true" > ./i_o.yml
			echo "jpegtran:" >> ./i_o.yml
			echo "  progressive: false" >> ./i_o.yml
			echo "optipng:" >> ./i_o.yml
			echo "  level: 7" >> ./i_o.yml
			echo "  interlace: false" >> ./i_o.yml
			echo "pngcrush:" >> ./i_o.yml
			echo "  fix: true" >> ./i_o.yml
			echo "  brute: true" >> ./i_o.yml
			echo "pngquant:" >> ./i_o.yml
			echo "  speed: 11" >> ./i_o.yml
		fi
		image_optim -r $3 --config-paths i_o.yml
		if [ $RM -eq "1" ]; then
			rm ./i_o.yml
		fi
		picopt -r $3
		imageoptim -d $3 -q
	fi
}


## EndNote

concatEndnoteXml() {
	for x in *.xml; do mv $x $x.old; sed 's/<?xml version="1.0" encoding="UTF-8" ?><xml><records>/ /g' $x.old > $x; rm $x.old; done
	for x in *.xml; do mv $x $x.old; sed 's/<\/records><\/xml>/ /g' $x.old > $x; rm $x.old; done
	find . -type f -name '*.xml' -exec cat {} + >> all.txt
	(echo '<?xml version="1.0" encoding="UTF-8" ?><xml><records>' ; cat all.txt ; echo '</records></xml>') > all.xml
	rm all.txt
}


## VLC
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC -I rc'

