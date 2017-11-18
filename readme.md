My tmux configuration
=====================

Prerequisites
-------------
This repo only installs `tmux.conf` files and related (plugins, scripts, themes, etc). It does not however install tmux, and requires you to do it yourself.

Installation
------------

```
$ git clone <url> <dir>
$ <dir>/install.sh
```

Installation script does following:

1. Init & update git submodules (tmux plugins)
1. Copy files to `$HOME/.tmux` directory, preserving existing file if any (most likely tmux plugins files)
1. Check if you don't have tmux installed and warn you
1. Create symlink at `$HOME/.tmux.conf`, and gently prompts you, if you already have one

Files
-----

<table>
    <tr>
        <td><code>tmux/tmux.conf</code></td>
        <td>Main tmux configuration file (general settings, bindings, plugins, etc)</td>
    </tr>
    <tr>
        <td><code>tmux/theme.conf</code></td>
        <td>Appearance settings and status bar setup</td>
    </tr>
</table>

Keybindings
-----------

- [ ] TODO: describe keybindin gscheme

Screenshots
-----------

- [ ] TODO: put eye-catching screenshots as soon as I'm done with status bar

Here what you would get:
