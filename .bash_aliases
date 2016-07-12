#!/usr/local/bin/bash

# bash_aliases

## Meta

### Allow aliases to be with sudo
alias sudo="sudo "

### list aliases
alias aliases="c ~/.dotfiles/bash/bash_aliases"


## apps
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC -I rc'
alias date='gdate'


## emulators
alias iphone='xcrun instruments -w "iPhone 6s (9.2) [968148E1-ED18-4AD4-ADE0-E1D0FF583E0E]"'
alias ipad='xcrun instruments -w "iPad Air 2 (9.0) [803FB64B-40A6-413F-8CA4-FA4883138F17]"'


## grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


## ls
alias ls='ls -F'
alias ll='ls -al'
alias la='ls -A'
alias l='ls -C'


## navigation
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"


## sql

alias sql="mysql -u root -p"
alias sqld="mysqldump -u root -p"


## git

### Open any files marked as “modified” in your default editor.
alias changed='open `git status --porcelain | sed -ne "s/^ M //p"`'

### Create SVN-style patch
alias svnpatch="git diff master... --no-prefix > "


## network

### IP addresses
alias ip='IP=`dig +short myip.opendns.com @resolver1.opendns.com`; growlnotify -s -a terminal -t "IP Address" -m "${IP}"'
alias lip='IP=`ipconfig getifaddr en0`; growlnotify -s -a terminal -t "Local IP" -m "${IP}"'

### Copy my public key to the pasteboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"

### Flush DNS cache
alias flushdns="sudo discoveryutil mdnsflushcache && sudo killall -HUP mDNSResponder && sudo dscacheutil -flushcache"


## system

### Empty the Trash on all mounted volumes and the main HDD
### Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

### Show/hide hidden files in Finder
alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

### Hide/show all desktop icons (useful when presenting)
alias showdeskicons="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedeskicons="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
