#!/bin/bash

set -e
set -u

is_app_installed() {
  type "$1" &>/dev/null
}

REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPODIR";

git submodule update --recursive --init --quiet;

if ! is_app_installed tmux; then
  printf "$(tput setaf 1)WARNING:$(tput sgr0) \"tmux\" command is not found. \
Install \"tmux\" yourself\n"
fi

# .tmux may already exist (created by tmux plugin manager)
rsync -aq --backup ./tmux/ "$HOME"/.tmux

if [ -e "$HOME/.tmux.conf" ]; then
  printf "Found existing .tmux.conf in your \$HOME directory. Will backup it and overwrite with new .tmux.conf file? OK (y/n): "
  read -r answer
  if echo "$answer" | grep -iq "^n"; then
    printf "Install config manually using command below:\n\n";
    printf "\t cd && ln -sf .tmux/tmux.conf .tmux.conf\n";
    exit 1;
  fi
fi

ln -sf --backup=numbered .tmux/tmux.conf  "$HOME"/.tmux.conf;
printf "$(tput setaf 2)OK:$(tput sgr0) Files are copied to \$HOME/.tmux and symlink at \$HOME/.tmux.conf is created\n"



