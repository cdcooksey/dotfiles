export XDG_CONFIG_HOME="$HOME/.config"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

ZSH_THEME="agnoster"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  bundler
  cp # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/cp
  command-not-found # https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/command-not-found/README.md
  debian
  docker-compose # https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/docker-compose/README.md
  git
  vi-mode
  systemd # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/systemd
  zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

EDITOR="vim"
GIT_EDITOR="vim"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias mvim="vim"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/Downloads/RubyMine-2021.2/bin"

alias rbenv-install-local="rbenv install $(cat .ruby-version)"
alias ls="ls --color"
alias bi="BUNDLE_FORCE_RUBY_PLATFORM=1 bundle install"
alias xgp="git push --tags --set-upstream origin $(git branch -q --show-current)"
alias gfindhistory="alias | grep ($1)"
eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh
source $HOME/.zshenv
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf
source $HOME/.config/zsh/completion.zsh
source $HOME/.config/zsh/key-bindings.zsh
