# If you come from bash you might have to change your $PATH.
TOUCHBAR_GIT_ENABLED=true
# export PATH=$HOME/bin:/usr/local/bin:$PATH

HISTORY_IGNORE="[a-zA-Z]|[a-zA-Z][a-zA-Z]|[a-zA-Z][a-zA-Z][a-zA-Z]|[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]" # ignore one key commands
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt HIST_NO_FUNCTIONS
setopt NO_EXTENDED_HISTORY
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt NO_SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Path to your oh-my-zsh installation.
export ZSH=/Users/pin/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
export plugins=(git zsh-iterm-touchbar)

# source $ZSH/oh-my-zsh.sh

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

source ~/.zsh/index

# source ~/zsh-interactive-cd.plugin.zsh

alias vim='nvim'
alias la='ls -lah'
alias sz='source ~/.zshrc'
alias du='du -d 1 -h'
alias rs='rails server'
alias gpo='git pull origin $(git branch | grep \* | sed "s/*\s*//g")'
alias gpm="git pull origin master"
alias gpd="git pull origin develop"
alias start='git flow feature start'

alias nrd='npm run dev'

alias adb="~/Dist/platform-tools/adb"
alias fastboot="~/Dist/platform-tools/fastboot"

srbenv() {
  export PATH="$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
}

snvm() {
  export NVM_DIR="$HOME/.nvm"
  # . "$(brew --prefix nvm)/nvm.sh" # MacOS
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

# export PATH="$PATH:/usr/local/Cellar/openvpn/2.4.4/sbin"

export PATH="$PATH:$HOME/Dist/gcc-arm-none-eabi-7-2018-q2-update/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
