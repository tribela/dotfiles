#!/bin/bash
path=`dirname $(readlink -e $0)`
cd $path
git submodule update --init

files=('.bashrc' '.gitconfig' '.ideavimrc' '.oh-my-zsh' '.pentadactylrc' '.tmux.conf' '.vim' '.vimrc' '.zshrc')

for file in ${files[@]}; do
    ln -sf $path/$file ~/$file
done

./.fzf/install

vim +PlugInstall +qall

mkdir -p "$HOME/.local/bin"
ln -sf $path/tmx $HOME/.local/bin/tmx
