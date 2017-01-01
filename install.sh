#!/bin/bash
path=`dirname $(readlink -e $0)`
cd $path

files=('.bashrc' '.gitconfig' '.ideavimrc' '.pentadactylrc' '.tmux.conf' '.vim' '.vimrc' '.zshrc')

for file in ${files[@]}; do
    ln -sf $path/$file ~/$file
done

\curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if hash nvim; then
    \curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +qall

mkdir -p "$HOME/.local/bin"
ln -sf $path/tmx $HOME/.local/bin/tmx

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$HOME/.fzf/install
