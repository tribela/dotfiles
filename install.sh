#!/bin/bash
path=$(dirname "$(readlink -e "$0")")
cd "$path" || true

files=('.bashrc' '.gitconfig' '.ideavimrc' '.tmux.conf' '.zshrc' '.zprofile' '.npmrc' '.sqliterc')

for file in "${files[@]}"; do
    ln -sfT "$path/$file" "$HOME/$file"
done

for file in .config/*; do
    ln -sfT "$path/$file" "$HOME/$file"
done

if [ -e "$path/tridactylrc" ]; then
    mkdir -p "$HOME/.config/tridactyl"
    ln -sfT "$path/tridactylrc" "$HOME/.config/tridactyl/tridactylrc"
fi

# Vim
'curl' -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf "$path/init.vim" ~/.vimrc
mkdir -p "$HOME/.vim" || true
for fname in vim/*; do
	ln -sf "$path/$fname" ~/.vim/
done
vim +PlugUpgrade +PlugInstall +qall

# Neovim
ln -sfT "$path/nvim" ~/.config/nvim

mkdir -p "$HOME/.local/bin"
ln -sf "$path/tmx" "$HOME/.local/bin/tmx"

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
"$HOME/.fzf/install" --all
