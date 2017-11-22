Tmux 2 Configuration
=====================
Tmux configuration, that supercharges your "tmux" terminal environment, and make you feel like a boss.

![intro](https://user-images.githubusercontent.com/768858/33152741-ec5f1270-cfe6-11e7-9570-6d17330a83aa.gif)

Features
---------

- "C-a" prefix instead of "C-b" (screen like)
- support for nested tmux sessions
- configurable visual theme/colors, with some elements borrowed from [Powerline](https://github.com/powerline/powerline)
- can apply different configuration whether your session is on local or remote machine
- supercharged and cozy status line
- status line: CPU, memory usage, system load average metrics
- status line: username and hostname, current date time
- status line: battery information in status line
- status line: visual indicator when you press `prefix`
- status line: visual indicator when pane is zoomed
- status line: online/offline visual indicator
- toggle visibility of status line
- monitor windows for activity/silence
- scroll and copy mode improvements
- prompt to rename window right after it's created
- highlight focused pane
- merge current session with existing one (move all windows)
- integration with 3rd party plugins: [tmux-sidebar](https://github.com/tmux-plugins/tmux-sidebar), [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat), [tmux-open](https://github.com/tmux-plugins/tmux-open), [tmux-plugin-sysstat](https://github.com/samoshkin/tmux-plugin-sysstat)

TBD:
- [ ] retain current path when new pane is created
- [ ] integration with clipboard
- [ ] fix pane resizing
- [ ] fix installation script to properly install TPM


Installation
-------------
The prerequisite is to install tmux >= "2.4".

```
$ git clone https://github.com/samoshkin/tmux-config.git
$ ./tmux-config/install.sh
```

Installation script will copy files to `~/.tmux` directory, symlink main `~/.tmux` config file, install Tmux plugin manager (if not already installed), install configured tmux plugins. If you already have existing `~/tmux.conf`, backup will be created.


General settings
----------------
Windows and pane indexing starts from `1` rather than `0`. Scrollback history limit is set to `20000`. Automatic window renameing is turned off. Aggresive resizing is on. Message line display timeout is `1.5s`. Mouse support in `on`.

256 color palette support is turned on, make sure that your parent terminal is configured propertly. See [here](https://unix.stackexchange.com/questions/1045/getting-256-colors-to-work-in-tmux) and [there](https://github.com/tmux/tmux/wiki/FAQ)

```
# parent terminal
$ echo $TERM
xterm-256color

# jump into a tmux session
$ tmux new
$ echo $TERM
screen-256color
```

Key bindings
-----------
So `~/.tmux.conf` overrides default key bindings for many action, to make them more reasonable, easy to recall and comforable to type.

Let's go through them:

<table>
    <tr>
        <td nowrap><code>C-a</code></td>
        <td>Default prefix, used instead of "C-b". Same prefix is used in screen program, and it's easy to type. The only drawback of "C-a" is that underlying shell does not receive the keystroke to move to the beginning of the line.
        </td>
    </tr>
    <tr>
        <td nowrap><code>&lt;prefix&gt; C-e</code></td>
        <td>Open ~/.tmux.conf file in your $EDITOR</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-r</code></td>
        <td>Reload tmux configuration from ~/.tmux.conf file</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; r</code></td>
        <td>Rename current window</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; R</code></td>
        <td>Rename current session</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; _</code></td>
        <td>Split new pane horizontally</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; |</code></td>
        <td>Split new pane vertically</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; &lt;</code></td>
        <td>Move to previous window</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; &gt;</code></td>
        <td>Move to next window</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; M-&lt;</code></td>
        <td>Move to previous window with alert</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; M-&gt;</code></td>
        <td>Move to next window with alert</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; Tab</code></td>
        <td>Switch to most recently used window</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; W</code></td>
        <td>Move to window by typing it's index</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; L</code></td>
        <td>Link window from another session by entering target session and window reference</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; \</code></td>
        <td>Swap panes back and forth with 1st pane. When in main-horizontal or main-vertical layout, the main panel is always at index 1. This keybinding let you swap secondary pane with main one, and do the opposite.</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; o and O</code></td>
        <td>Select/focus panes in forward and backward direction</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-o</code></td>
        <td>Swap current active pane with next one</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; +</code></td>
        <td>Toggle zoom for current pane</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; x</code></td>
        <td>Kill current pane</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; X</code></td>
        <td>Kill current window</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-x</code></td>
        <td>Kill other windows but current one (with confirmation)</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-q</code></td>
        <td>Kill current session (with confirmation)</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-u</code></td>
        <td>Merge current session with another. Essentially, this moves all windows from current session to another one</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; d</code></td>
        <td>Detach from session</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; D</code></td>
        <td>Detach other clients except current one from session</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-s</code></td>
        <td>Toggle status bar visibility</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; m</code></td>
        <td>Monitor current window for activity</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; M</code></td>
        <td>Monitor current window for silence by entering silence period</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; F12</code></td>
        <td>Switch off all key binding and prefix hanling in current window. See "Nested sessions" paragraph for more info</td>
    </tr>
</table>


Status line
-----------

I've started with Powerline as a status line, but then realized it's too fat for my Macbook 15'' display, it hardly can fit all those fancy arrows, widgets and separators, so that I can only see one window "tab".

So I decide to make my feet wet, with the idea to keep it dense, and include essential widgets. Sometimes it tries to replicate OSX topbar (battery, date time).

Left part:
![status line left](https://user-images.githubusercontent.com/768858/33151594-59db6a8e-cfe1-11e7-8a36-476fe0b416b3.png)

Right part:
![status line right](https://user-images.githubusercontent.com/768858/33151608-6978de72-cfe1-11e7-829a-e303e31e8c16.png)

The left part contains only current session name.

Window tabs use Powerline arrows glyphs, so you need to install Powerline enabled font to make this work. See [Powerline docs](https://powerline.readthedocs.io/en/latest/installation.html#fonts-installation) for instructions and here is the [collection of patched fonts for powerline users](https://github.com/powerline/fonts)

The right part of status line consists of following components:

- CPU, memory usage, system load average metrics. Powered by [tmux-plugin-sysstat](https://github.com/samoshkin/tmux-plugin-sysstat) (dislaimed, that's my own development, because I haven't managed to find any good plugin with CPU and memory/swap metrics)
- username and hostname (invaluable when you SSH onto remote host)
- current date time
- battery information
- visual indicator when you press prefix key: `[^A]`.
- visual indicator when pane is zoomed: `[Z]`
- online/offline visual indicator (just pings `google.com`)

You might want to hide status bar using `<prefix> C-s` keybinding.


Nested tmux sessions
--------------------
One prefers using tmux on local machine to supercharge their terminal emulator experience, other use it only for remote scenarios to retain session/state in case of disconnect. Things are getting more complex, when you want to be on both sides. You end up with nested session, and face the question: **How you can control inner session, since all keybindings are caught and handled by outer session?**. Community provides several possible solutions.

The most common is to press `C-a` prefix twice. First one is caught by local session, whereas second is passed to remote one. Nothing extra steps need to be done, this works out of the box. However, root keytable bindings are still handled by outer session, and cannot be passed to inner one.

Second attempt to tackle this issue, is to [setup 2 individual prefixes](https://simplyian.com/2014/03/29/using-tmux-remotely-within-a-local-tmux-session/), `C-b` for local session, and `C-a` for remote session. And, you know, it feels like:

![tmux in tmux](http://i.imgur.com/HQBdV1J.jpg)

And finally accepted solution, turn off all keybindings and key prefix handling in outer session, when working with inner one. This way, outer session just sits aside, without interfering keystrokes passed to inner session. Credits to [http://stahlke.org/dan/tmux-nested/](http://stahlke.org/dan/tmux-nested/) and this [Github issue](https://github.com/tmux/tmux/issues/237)

So, how it works. When in outer session, simply press `F12` to toggle off all keybindings handling in outer session. Now work with inner session using the same keybinding scheme and same keyprefix. Press `F12` to turn on outer session back.

![nested sessions](https://user-images.githubusercontent.com/768858/33151636-84a0bab2-cfe1-11e7-9d5d-412525689c9b.gif)

You might notice that when key bindings are "OFF", special `[OFF]` visual indicator is shown in the status line, and status line changes its style (colored to gray).

###  Local and remote sessions

Remote session is detected by existence of `$SSH_CLIENT` variable. When session is remote, following changes are applied:
- status line is docked to bottom; so it does not stack with status line of local session
- some widgets are removed from status line: battery, date time. The idea is to economy width, so on wider screens you can open two remote tmux sessions in side-by-side panes of single window of local session.

You can apply remote-specific settings by extending `~/.tmux/.tmux.remote.conf` file.


Themes and customization
------------------------

All colors related to theme are declared as variables. You can change them in `~/.tmux.conf`.

```
# This is a theme CONTRACT, you are required to define variables below
# Change values, but not remove/rename variables itself
color_dark="$color_black"
color_light="$color_white"
color_session_text="$color_blue"
color_status_text="colour245"
color_main="$color_orange"
color_secondary="$color_purple"
color_level_ok="$color_green"
color_level_warn="$color_yellow"
color_level_stress="$color_red"
color_window_off_indicator="colour088"
color_window_off_status_bg="colour238"
color_window_off_status_current_bg="colour254"
```

Note, that variables are not extracted to dedicated file, as it should be, because for some reasons, tmux does not see variable values after sourcing `theme.conf` file. Don't know why.

create several panes, windows
move between them
zoom window
open nested tmux session
scroll and copy
