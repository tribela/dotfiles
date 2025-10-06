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
plugins=(docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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

if hash nvim 2>/dev/null; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

ZSH_THEME_GIT_PROMPT_PREFIX='‹'
ZSH_THEME_GIT_PROMPT_SUFFIX='›'
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

unset -f get_rgb
unset -f get_255

parse_git_dirty () {
    local UNTRACKED
    local MODIFIED
    local STATUS
    STATUS=''
    MODIFIED=$(__git_prompt_git status --porcelain --untracked-files=no 2>/dev/null)
    if [[ -n $MODIFIED ]]
    then
        STATUS="${STATUS}+"
    fi
    UNTRACKED=$(__git_prompt_git ls-files -o --exclude-standard 2>/dev/null)
    if [[ -n $UNTRACKED ]]
    then
        STATUS="${STATUS}?"
    fi
    echo ${STATUS}
}

export PS1='%{${username_color}%}%n%{${reset_color}%}@%{${host_color}%}%m%{${fg_bold[magenta]}%}:%{$reset_color%}%{${fg[green]}%}%3~ %{${fg[yellow]}%}$(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}%#%{${reset_color}%} '

# brew
test -d "$HOME/.linuxbrew" && eval "$($HOME/.linuxbrew/bin/brew shellenv)"
test -d "/home/linuxbrew/.linuxbrew" && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Pyenv
if ! which pyenv &>/dev/null && [ -d "$HOME/.pyenv/bin" ]; then
    export PATH=$HOME/.pyenv/bin:$PATH
fi
if which pyenv &>/dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
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
fi
if hash rbenv &>/dev/null; then
    eval "$(rbenv init -)"
fi

if hash brew &>/dev/null; then
	export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"
fi

# direnv
if which direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
    alias tmux='direnv exec / tmux'
fi

# Node
if [ -d "$HOME/.volta" ]; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
elif [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/bash_completion"  ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    # Lazy load
    for command in {nvm,node,npm,yarn,corepack}; do
        alias $command="unalias nvm node npm yarn corepack && \. $NVM_DIR/nvm.sh && $command"  # This loads nvm
    done

    # Instant load
    # . $NVM_DIR/nvm.sh
fi

# ccache
if [ -d /usr/lib/ccache ]; then
    export PATH=/usr/lib/ccache:$PATH
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit

# Sanitise path
export PATH=${$(echo $PATH | tr : '\n' | cat -n | sort -u -k2 | sort -gk1 | cut -f2 | tr '\n' :)%:}


# Aliases and functions

# Vim vs Nvim
if which nvim &>/dev/null; then
    alias vim=nvim
    export EDITOR=nvim
fi

alias df='df -h -x tmpfs -x devtmpfs -x squashfs'
alias ip='ip -br'
alias gpg='gpg --no-symkey-cache'
alias xc='xclip -sel clipboard'

ttfb() {
    curl -so /dev/null -w "HTTP %{http_version} %{http_code} Remote IP: %{remote_ip}\nDNS: %{time_namelookup}\nConnect: %{time_connect}\nTTFB: %{time_starttransfer}\nTotal time: %{time_total}\nDownload speed: %{speed_download}bps\nBytes: %{size_download}\n" $@
}

ipget() {
    https "ifconfig.co/json?ip=$1"
}

tlscheck() {
    local host=$1
    local port=${2:-443}
    echo | openssl s_client -servername $host -connect $host:$port | openssl x509 -noout -dates
}

ap() {
    https $@ Accept:application/activity+json
}

shodan() {
    xdg-open https://shodan.io/domain/$1
    dig +short $1 | xargs -i xdg-open https://shodan.io/host/{}
}

check_mtu() {
    local target=$1
    shift
    local lower=0
    local upper=1500
    until [[ $((lower + 1)) -eq $upper ]]; do
        current=$(((lower + upper) / 2))
        echo -n "lower: $lower, upper: $upper, testing: $current -- "
        if ping -M do -s $current -c 2 -i 0.2 $target $@ &> /dev/null; then
            echo "ok"
            lower=$current
        else
            echo "fail"
            upper=$current
        fi
    done

    echo "max packet size: $lower, mtu: $((lower + 28))"
}

unbrew() {
    export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/home/linuxbrew' | tr '\n' ':' | sed 's/:$//')
}
