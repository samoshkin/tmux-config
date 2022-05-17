#!/usr/bin/env bash

set -e
set -u
set -o pipefail

is_app_installed() {
    type "$1" &>/dev/null
}

REPODIR="$(
    cd "$(dirname "$0")"
    pwd -P
)"
cd "$REPODIR"

if ! is_app_installed tmux; then
    printf "WARNING: \"tmux\" command is not found. \
        Install it first\n"
    exit 1
fi

if [ ! -e "$XDG_CONFIG_HOME/.config/tmux/plugins/tpm" ]; then
    printf "WARNING: Cannot found TPM (Tmux Plugin Manager) \
        at default location: \$HOME/config/tmux/plugins/tpm.\n"
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

if [ -e "$HOME/.tmux.conf" ]; then
    printf "Found existing .tmux.conf in your \$XGD_CONFIG_HOME directory.\
        Will create a backup at $XDG_CONFIG_HOME/tmux/tmux.conf.bak\n"
    cp -f "$HOME/.tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf.bak" 2>/dev/null || true
fi

cp -a ./tmux/. "$XDG_CONFIG_HOME"/tmux/

# Install TPM plugins.
# TPM requires running tmux server, as soon as `tmux start-server` does not work
# create dump __noop session in detached mode, and kill it when plugins are installed
printf "Install TPM plugins\n"
tmux new -d -s __noop >/dev/null 2>&1 || true
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.config/tmux/plugins"
"$XDG_CONFIG_HOME"/tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

printf "OK: Completed\n"
printf "Please add an alias to TMUX >= 3.2: alias tmux='tmux -f ~/.config/tmux/tmux.conf'\n"
