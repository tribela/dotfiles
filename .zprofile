# export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

unset PYENV_VERSION

# linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

# Pyenv
if ! which pyenv &>/dev/null && [ -d "$HOME/.pyenv/bin" ]; then
    export PATH=$HOME/.pyenv/bin:$PATH
fi
if which pyenv &>/dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    source "$(pyenv root)/completions/pyenv.zsh"
fi

# Virtualenv wrapper
if ! which mktmpenv &>/dev/null; then
    if which pyenv &>/dev/null; then
        pyenv virtualenvwrapper_lazy
    elif which virtualenvwrapper_lazy.sh &>/dev/null; then
        # export VIRTUALENVWRAPPER_SCRIPT="$HOME/.local/bin/virtualenvwrapper.sh"
        # source ~/.local/bin/virtualenvwrapper_lazy.sh
        export VIRTUALENVWRAPPER_SCRIPT=$(which virtualenvwrapper.sh)
        source $(which virtualenvwrapper_lazy.sh)
    fi
fi

# Rbenv
if [ -d "$HOME/.rbenv/bin" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# direnv
if which direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
    alias tmux='direnv exec / tmux'
fi

# added by travis gem
[ -f /home/kjwon15/.travis/travis.sh ] && source /home/kjwon15/.travis/travis.sh

# Alias for damn flake8
alias flake8="flake8 --append-config=$HOME/.config/flake8"

# NVM
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/bash_completion"  ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    for command in {nvm,node,npm}; do
        alias $command="unalias nvm node npm && \. $NVM_DIR/nvm.sh && $command"  # This loads nvm
    done
fi

# ccache
if [ -d /usr/lib/ccache ]; then
    export PATH=/usr/lib/ccache:$PATH
fi


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
