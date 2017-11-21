#!/bin/bash

set -e
set -u

is_app_installed() {
  type "$1" &>/dev/null
}

REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPODIR";

if ! is_app_installed tmux; then
  printf "$(tput setaf 1)WARNING:$(tput sgr0) \"tmux\" command is not found. \
Install it first\n"
  exit 1
fi

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  printf "$(tput setaf 1)WARNING:$(tput sgr0) Cannot found TPM (Tmux Plugin Manager) \
 at default location: \$HOME/.tmux/plugins/tpm. Install it first\n"
  exit 1
fi

if [ -e "$HOME/.tmux.conf" ]; then
  printf "Found existing .tmux.conf in your \$HOME directory. Will create a backup at $HOME/.tmux.conf.bak\n"
fi

git submodule init;

rsync -aq ./tmux/ "$HOME"/.tmux

ln -sf --backup --suffix=.bak .tmux/tmux.conf "$HOME"/.tmux.conf;

"$HOME"/.tmux/plugins/tpm/bin/install_plugins

printf "$(tput setaf 2)OK:$(tput sgr0) Completed\n"












