export EDITOR='vim'
export PS1='\u@\h:\W $'
alias ls='ls -G'
alias ll='ls -l'
alias lf='ls -F'
alias gitk='gitk --all'

export LC_CTYPE='ko_KR.UTF-8'

source ~/.profile


if which vcprompt; then
    export VCPROMPT_FORMAT='[0;34m<%b%m%u>[m'
    export PS1='\[\e[0;32m\]\u\[\e[m\]\[\e[39m\]@\[\e[36m\]\h:\[\e[33m\]\w\[\e[m\] $(vcprompt)\[\e[1;31m\]\$\[\e[m\] '
else
    export PS1='\[\e[0;32m\]\u\[\e[m\]\[\e[39m\]@\[\e[36m\]\h:\[\e[33m\]\w\[\e[m\]\[\e[1;31m\]\$\[\e[m\] '
fi

