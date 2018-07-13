#!/usr/bin/env bash

set -e
set -u
set -o pipefail

is_app_installed() {
  type "$1" &>/dev/null
}

REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPODIR";

if ! is_app_installed tmux; then
  printf "WARNING: \"tmux\" command is not found. Install it first\n"
  exit 1
fi

if [ ! -e "$HOME/.tmux/plugins" ]; then
  mkdir -p ~/.tmux/plugins
fi

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  printf "WARNING: Cannot found TPM (Tmux Plugin Manager) at default location: \$HOME/.tmux/plugins/tpm.\n"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ -e "$HOME/.tmux.conf" ]; then
  tmuxbak="$HOME/.tmux.conf.bak$(date +%Y%m%d_%H%M%S)"
  printf "Found existing ~/.tmux.conf in your \$HOME directory. Creating a backup at $tmuxbak\n"
  cp -f "$HOME/.tmux.conf" "$tmuxbak" 2>/dev/null || true
fi

if [ ! -e "$HOME/.tmux.conf.local" ]; then
  touch $HOME/.tmux.conf.local
fi

cp -a ./tmux/renew_env.sh ~/.tmux/
cp -a ./tmux/tmux.remote.conf ~/.tmux/
cp -a ./tmux/yank.sh ~/.tmux/
#ln -sf "${PWD}"/tmux/tmux.conf ~/.tmux.conf;
cp -a ./tmux/tmux.conf ~/.tmux.conf

# Install TPM plugins.
# TPM requires running tmux server, as soon as `tmux start-server` does not work
# create dump __noop session in detached mode, and kill it when plugins are installed
printf "Installing TPM plugins\n"
tmux new -d -s __noop >/dev/null 2>&1 || true 
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
~/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

printf "OK: Completed\n"
