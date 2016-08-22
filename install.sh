#!/bin/bash
path=`dirname $(readlink -e $0)`
cd $path
git submodule update --init

files=('.bashrc' '.gitconfig' '.ideavimrc' '.pentadactylrc' '.tmux.conf' '.vim' '.vimrc' '.zshrc')

for file in ${files[@]}; do
    ln -sf $path/$file ~/$file
done


vim +PlugInstall +qall

mkdir -p "$HOME/.local/bin"
ln -sf $path/tmx $HOME/.local/bin/tmx

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
./.fzf/install
