#!/usr/local/bin/bash

# bash_functions

## update package managers
packup() {
  # apple software update
  printf "\n~~Apple Software Update~~\n\n"
  sudo softwareupdate --install --all

  # ruby gems
  printf "\n\n~~Ruby Gems~~\n"

  printf "\n~2.1.6~\n"
  chruby 2.1.6
  sudo gem update
  sudo gem cleanup
  sudo gem update
  if [ "$1" = "local" ]; then
    bundle install
  fi

  printf "\n~2.2.3p172-shopify~\n"
  chruby 2.2.3p172-shopify
  sudo gem update
  sudo gem cleanup
  sudo gem update
  if [ "$1" = "local" ]; then
    bundle install
  fi

  printf "\n\n~2.3.0~\n"
  chruby 2.3.0
  sudo gem update
  sudo gem cleanup
  sudo gem update
  if [ "$1" = "local" ]; then
    bundle install
  fi

  printf "\n\n~2.3.1~\n"
  chruby 2.3.1
  sudo gem update
  sudo gem cleanup
  sudo gem update
  if [ "$1" = "local" ]; then
    bundle install
  fi

  # homebrew
  printf "\n\n~~Homebrew~~\n"
  brew update
  brew upgrade --all
  brew cleanup
  brew prune

  # node
  printf "\n\n~~Node~~\n"
  npm update -g
  if [ "$1" = "local" ]; then
    npm update
  fi

  # xcode command line tools
  printf "\n\n~~Xcode command line tools~~\n"
  xcode-select --install

  # dev
  dev update

  # app store
  printf "\n\n~~App Store~~\n"
  open /Applications/App\ Store.app
}


## update repo
updaterepo() {
  git checkout master
  brew update
  brew upgrade --all
  brew cleanup
  brew prune
  npm update -g
  npm update
  dev update
  git pull
  dev up
  bundle exec rake db:test:prepare
  echo -e "\n\n\n\n\n"
  git status
  git branch
}


## send SMS
sendtext () { curl http://textbelt.com/text -d number=6476696398 -d "message=$1";echo message sent; }


## resize with ImageMagick
smartresize() {
  mogrify -path $3 -filter Triangle -define filter:support=2.0 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
    if [ $4 -eq "1" ]; then
    RM="0"
    if [ ! -f ./i_o.yml ]; then
    RM="1"
      echo "nice: 10" > ./i_o.yml
      echo "verbose: true" > ./i_o.yml
      echo "pack: true" > ./i_o.yml
      echo "skip_missing_workers: true" > ./i_o.yml
      echo "allow_lossy: false" > ./i_o.yml
      echo "advpng:" > ./i_o.yml
      echo "  level: 4" > ./i_o.yml
      echo "gifsicle:" > ./i_o.yml
      echo "  interlace: false" > ./i_o.yml
      echo "  level: 3" > ./i_o.yml
      echo "  careful: true" > ./i_o.yml
      echo "jpegoptim:" > ./i_o.yml
      echo "  strip: all" > ./i_o.yml
      echo "jpegrecompress:" > ./i_o.yml
      echo "  quality: 3" > ./i_o.yml
      echo "jpegtran:" > ./i_o.yml
      echo "  copy_chunks: false" > ./i_o.yml
      echo "  progressive: false" > ./i_o.yml
      echo "  jpegrescan: true" > ./i_o.yml
      echo "optipng:" > ./i_o.yml
      echo "  level: 7" > ./i_o.yml
      echo "  interlace: false" > ./i_o.yml
      echo "  strip: true" > ./i_o.yml
      echo "pngcrush:" > ./i_o.yml
      echo "  chunks: alla" > ./i_o.yml
      echo "  fix: true" > ./i_o.yml
      echo "  brute: true" > ./i_o.yml
      echo "  blacken: true" > ./i_o.yml
      echo "pngquant:" > ./i_o.yml
      echo "  speed: 1" > ./i_o.yml
    fi
    image_optim -r $3 --config-paths i_o.yml
    if [ $RM -eq "1" ]; then
      rm ./i_o.yml
    fi
    picopt -r $3
    imageoptim -d $3 -q
  fi
}


## concat EndNote XML
concatEndnoteXml() {
  for x in *.xml; do mv $x $x.old; sed 's/<?xml version="1.0" encoding="UTF-8" ?><xml><records>/ /g' $x.old > $x; rm $x.old; done
  for x in *.xml; do mv $x $x.old; sed 's/<\/records><\/xml>/ /g' $x.old > $x; rm $x.old; done
  find . -type f -name '*.xml' -exec cat {} + >> all.txt
  (echo '<?xml version="1.0" encoding="UTF-8" ?><xml><records>' ; cat all.txt ; echo '</records></xml>') > all.xml
  rm all.txt
}


## :tophat: shopify_app repo
function tophat_shopify_app {
  if [[ ! -d "shopify_app" ]]; then
    echo "shopify_app gem is not in this directory"
    return
  fi

  usage='usage: tophat_shopify_app <api_key> <api_secret>'

  if [[ -z "$1" ]]; then
    echo $usage
    return
  fi

  if [[ -z "$2" ]]; then
    echo $usage
    return
  fi

  currentDir=$(pwd)

  echo 'rails new testapp'
  rails new testapp

  cd testapp

  echo 'add shopify_app gem'
  echo "gem 'shopify_app', path: '$currentDir/shopify_app'" >> Gemfile
  bundle install

  echo 'run shopify_app generator'
  spring stop
  rails g shopify_app -api_key=$1 -secret=$2 -redirect_uri=http://localhost:3000/auth/shopify/callback

  echo 'migrate db'
  bundle exec rake db:migrate

  echo 'start server'
  bundle exec rails server
}


## gitwho: see who worked on a file, so I can ping them in PRs
gitwho() {
  git log --format="%an" -- "$@" | sort | uniq -c | sort -rn
}


## blowupshop: destroy and rebuild the database
blowupshop() {
  git checkout master
  dev down
  dev reset-data
  updaterepo
}
