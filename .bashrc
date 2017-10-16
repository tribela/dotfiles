export EDITOR='vim'
export PS1='\u@\h:\W $'
alias ls='ls -G --color=auto'
alias ll='ls -l'
alias lf='ls -F'
alias gitk='gitk --all'

mkcd() { mkdir -p "$1" && cd "$1"; }


if which vcprompt > /dev/null; then
    export VCPROMPT_FORMAT='[0;34m<%b%m%u>[m'
    export PS1='\[\e[0;32m\]\u\[\e[39m\]@\[\e[36m\]\h:\[\e[33m\]\w\[\e[m\] \[$(vcprompt)\]\[\e[1;31m\]\$\[\e[m\] '
else
    export PS1='\[\e[0;32m\]\u\[\e[m\]\[\e[39m\]@\[\e[36m\]\h:\[\e[33m\]\w\[\e[m\]\[\e[1;31m\]\$\[\e[m\] '
fi

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# pyenv
if [ -d $HOME/.pyenv/bin ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi


# virtualenvwrapper
if hash pyenv 2>/dev/null; then
    pyenv virtualenvwrapper_lazy
elif hash virtualenvwrapper_lazy.sh 2>/dev/null; then
    export VIRTUALENVWRAPPER_SCRIPT=$(which virtualenvwrapper.sh)
    source $(which virtualenvwrapper_lazy.sh)
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# allow locally installed npm binaries to be executed;
# added by `npm i -g add-local-binaries-to-path`
export PATH="$PATH:./node_modules/.bin"
