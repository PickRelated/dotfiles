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

source ~/.zsh/index

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias vi='nvim'
alias vim='nvim'
# TODO: Replace with sh script respectinv vim file to try command on
# alias vimp="vim --cmd 'profile start vimrc.profile' --cmd 'profile! file ~/.vimrc' && cat vimrc.profile | grep '0\.\d\d[^0]' && rm vimrc.profile" # Profile vim loading time

export PAGER=vimpager

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk/Contents/Home"

# Add your exports in this file
source ~/.zsh/exports
