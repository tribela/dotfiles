#!/bin/bash
path=$(dirname "$(readlink -e "$0")")
cd "$path" || true

files=('.bashrc' '.gitconfig' '.ideavimrc' '.tmux.conf' '.vim' '.vimrc' '.zshrc' '.zprofile' '.npmrc' '.sqliterc')

for file in "${files[@]}"; do
    ln -sfT "$path/$file" "$HOME/$file"
done

if [ -e "$path/tridactylrc" ]; then
    mkdir -p "$HOME/.config/tridactyl"
    ln -sfT "$path/tridactylrc" "$HOME/.config/tridactyl/tridactylrc"
fi

'curl' -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugUpgrade +PlugInstall +qall

if hash nvim 2>/dev/null; then
    mkdir -p ~/.config/nvim
    'curl' -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln -sf "$path/.vimrc" ~/.config/nvim/init.vim
     ln -sfT "$path/.vim/snippets" ~/.config/nvim/snippets
    nvim +PlugUpgrade +PlugInstall +qall
fi

mkdir -p "$HOME/.local/bin"
ln -sf "$path/tmx" "$HOME/.local/bin/tmx"

# Install vcprompt

curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt -o ~/.local/bin/vcprompt
chmod +x ~/.local/bin/vcprompt

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
"$HOME/.fzf/install" --all

# Fix Ibus on QT5
./fix-ibus.sh
