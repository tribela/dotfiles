#!/bin/bash
path=`dirname $(readlink -e $0)`
cd $path

files=('.bashrc' '.gitconfig' '.ideavimrc' '.pentadactylrc' '.tmux.conf' '.vim' '.vimrc' '.zshrc')

for file in ${files[@]}; do
    ln -sfT $path/$file ~/$file
done

ln -sfT $path/i3 ~/.config/i3
ln -sfT $path/i3status ~/.config/i3status

\curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugUpgrade +PlugInstall +qall

if hash nvim 2>/dev/null; then
    mkdir -p ~/.config/nvim
    \curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln -sf $path/.vimrc ~/.config/nvim/init.vim
     ln -sfT $path/.vim/snippets ~/.config/nvim/snippets
    nvim +PlugUpgrade +PlugInstall +qall
fi

mkdir -p "$HOME/.local/bin"
ln -sf $path/tmx $HOME/.local/bin/tmx

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$HOME/.fzf/install --all

# Install ccsm profile
# Use abs path to ignore pyenv
/usr/bin/python << EOF
import compizconfig
context = compizconfig.Context()
context.Import('ccsm.profile')
EOF

# Map caps lock to additional ctrl key
./caps.sh
