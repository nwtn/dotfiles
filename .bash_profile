#!/bin/bash

# bash_profile

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
