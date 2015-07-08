#!/bin/bash
path=`dirname $(readlink -e $0)`
cd $path
git submodule update --init

files=('.bash_profile' '.gitconfig' '.ideavimrc' '.oh-my-zsh' '.pentadactylrc' '.tmux.conf' '.vim' '.vimrc' '.zshrc')

for file in ${files[@]}; do
    ln -sf $path/$file ~/$file
done
