#!/bin/bash
path=`dirname $(realpath $0)`
cd $path
git submodule update --init

files=('cake' 'lie' '.bash_profile' '.gitconfig' '.ideavimrc' '.oh-my-zsh' '.pentadactylrc' '.tmux.conf' '.vim' '.vimrc' '.zshrc')

for file in ${files[@]}; do
    ln -sf $path/$file ~/$file
done
