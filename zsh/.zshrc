HISTORY_IGNORE="[a-zA-Z]|[a-zA-Z][a-zA-Z]|[a-zA-Z][a-zA-Z][a-zA-Z]|[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]" # ignore one key commands
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_no_functions
setopt no_extended_history
setopt inc_append_history  # Write to the history file immediately, not when the shell exits.
setopt no_share_history    # Share history between all sessions.
setopt hist_ignore_dups    # Don't record an entry that was just recorded again.
setopt hist_find_no_dups   # Do not display a line previously found.
setopt hist_ignore_space   # Don't record an entry starting with a space.
setopt hist_reduce_blanks  # Remove superfluous blanks before recording entry.
setopt autocd

export TERM="screen-256color"

zstyle ':completion:*' list-colors 'di=94:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

export LC_ALL=C
export LC_CTYPE="UTF-8"
export LC_TERMINAL="iTerm2"
export LANG="en_RU"

# tab suggestions
zmodload zsh/complist
zstyle ':completion:*' menu select # better list completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive tab completion
bindkey -M menuselect '^h' vi-backward-char # use hjkl keys to navigate between suggestions
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# turn CTRL-z into a toggle switch
ctrlz() {
  if [[ $#BUFFER == 0 ]]; then
    fg >/dev/null 2>&1 && zle redisplay
  else
    zle push-input
  fi
}
zle -N ctrlz
bindkey '^Z' ctrlz

source ~/.zsh/index

alias vi='nvim'
alias vim='nvim'
