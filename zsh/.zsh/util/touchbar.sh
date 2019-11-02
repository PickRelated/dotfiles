#!/usr/bin/env bash
# vim: filetype=zsh

keys=(F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F20 F21 F22 F23 F24)
fnKeys=('^[OP' '^[OQ' '^[OR' '^[OS' '^[[15~' '^[[17~' '^[[18~' '^[[19~' '^[[20~' '^[[21~' '^[[23~' '^[[24~' '^[[1;2P' '^[[1;2Q' '^[[1;2R' '^[[1;2S' '^[[15;2~' '^[[17;2~' '^[[18;2~' '^[[19;2~')

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e 's/[()]//g'
}

itbranches() {
  currentMode='itbranches'
  ~/.iterm2/it2setkeylabel set F1 "back"
  bindkey -s $fnKeys[1]  "ithome\n"

  ~/.iterm2/it2setkeylabel set F2 "dev"
  bindkey -s $fnKeys[2]  "git checkout dev\n"

  i=3
  for branch in $(git branch | sed 's/[\* ]*[fix|snf|issue]*\///g'); do
    ~/.iterm2/it2setkeylabel set $keys[$i] "$branch"
    bindkey -s $fnKeys[$i]  "git checkout $branch\n"
    i=$(($i+1))
    if [ "$i" -gt 24 ]; then
      break
    fi
  done
}

ithome() {
  currentMode='ithome'
  cur_branch=$(parse_git_branch)
  ~/.iterm2/it2setkeylabel set F1 "🎋 $(echo $cur_branch | sed -e 's/[issue|snf|feature]*\///g')"
  ~/.iterm2/it2setkeylabel set F2 "🔽"
  ~/.iterm2/it2setkeylabel set F3 "🔼"
  bindkey -s $fnKeys[1]  "itbranches\n"
  bindkey -s $fnKeys[2]  "git pull origin $cur_branch\n"
  bindkey -s $fnKeys[3]  "git push origin $cur_branch\n"
}


if [ ! $initialized ]; then
  ithome
  initialized=true
fi

if [ $currentMode = "ithome" ]; then
  ithome
fi
