#!/bin/bash

# bash_profile

export PS1="\u@${HOSTNAME%%.*} \w 👍  "
export GYP_GENERATORS=ninja
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~} ${HOSTNAME%%.*}\007"'


declare -a files=(
    $HOME/.bash_config # Configuration
    $HOME/.bash_aliases # Aliases
    $HOME/.bash_paths # Path modifications (must source after `.bash_profile.local` in case of custom `brew` location)
)

# If these files are readable, source them
for index in ${!files[*]}
do
    if [[ -r ${files[$index]} ]]; then
        source ${files[$index]}
    fi
done

unset files

# Increase number of processes to 2048
# sometimes stops node from exlpoding
ulimit -n 2048
