# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="flazz"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git restic)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

unsetopt autocd

if [ ! -z "$COLORTERM" ] && [[ "$TERM" != *"-256color" ]]; then
    export TERM="${TERM}-256color"
fi

if hash nvim 2>/dev/null; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi


# "resize" command for GUI term
if [ ! -z "$XDG_CURRENT_DESKTOP" ]; then
    resize() {
        local cols=$1
        local lines=$2
        printf "\e[8;${lines};${cols}t"
    }
fi

if [[ -x $(which vcprompt) ]]; then
    export VCPROMPT_FORMAT='<%b%a%m%u> '
    alias git_prompt_info='vcprompt'
fi
if [[ -s /etc/zsh_command_not_found ]]; then
    source /etc/zsh_command_not_found
fi

abs() {
    [ $1 -lt 0 ] && echo $((- $1)) || echo $1
}

get_rgb() {
    n=$(md5sum <<< $1)
    n=$((0x${n:0:12}))
    local degree=$(($n % 360))
    local x=$((255 - $(abs $((${degree} * 255 / 60 % (255*2) - 255)) ) ))
    if [ $degree -lt 60 ]; then
        echo -n "255;$x;0"
    elif [ $degree -lt 120 ]; then
        echo -n "$x;255;0"
    elif [ $degree -lt 180 ]; then
        echo -n "0;255;$x"
    elif [ $degree -lt 240 ]; then
        echo -n "0;$x;255"
    elif [ $degree -lt 300 ]; then
        echo -n "$x;0;255"
    elif [ $degree -lt 360 ]; then
        echo -n "255;0;$x"
    fi
}

get_255() {
    n=$(md5sum <<< $1)
    n=$((0x${n:0:12}))
    echo -n "$(($n % 255))"
}

if [[ "$TERM" = "screen."* ]]; then
    username_color="[38;5;$(get_255 $USER)m"
    host_color="[38;5;$(get_255 $(hostname))m"
else
    username_color="[38;2;$(get_rgb $USER)m"
    host_color="[38;2;$(get_rgb $(hostname))m"
fi

export PS1='%{${username_color}%}%n%{${reset_color}%}@%{${host_color}%}%m%{${fg_bold[magenta]}%}:%{$reset_color%}%{${fg[green]}%}%3~ %{${fg[yellow]}%}$(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}%#%{${reset_color}%} '

# brew
test -d $HOME/.linuxbrew && eval $($HOME/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval $($(brew --prefix)/bin/brew shellenv)

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Sanitise path
export PATH=${$(echo $PATH | tr : '\n' | cat -n | sort -u -k2 | sort -gk1 | awk -c '{print $2}' | tr '\n' :)%:}
