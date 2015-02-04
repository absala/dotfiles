# Tmux sensible

A set of tmux options that should be acceptable for everyone.

Inspired by [vim-sensible](https://github.com/tpope/vim-sensible).

### Core principles

- core `tmux-sensible` options should be acceptable to **every** tmux user!<br/>
  If any option bothers you, please open an issue and it will probably be
  updated (or removed).
- if you think a new option should be added, feel free to open a pull request.
- **no overriding** of user defined settings.<br/>
  Your existing `.tmux.conf` settings are respected and they won't be changed.
  That way you can use `tmux-sensible` if you have a few specific options.

### Almost sensible principles

- widely used settings that do not make it into the 'core'
- explicitly enabled with `set -g @almost-sensible 'on'`

### Goals

- group standard tmux community options in one place
- remove clutter from your `.tmux.conf`
- educate new tmux users about basic options

### Core options

    # utf8 is on
    set -g utf8 on
    set -g status-utf8 on

    # address vim mode switching delay (http://superuser.com/a/252717/65504)
    set -s escape-time 0

    # increase scrollback buffer size
    set -g history-limit 50000

    # tmux messages are displayed for 4 seconds
    set -g display-time 4000

    # refresh 'status-left' and 'status-right' more often
    set -g status-interval 5

    # set only on OS X where it's required
    set -g default-command "reattach-to-user-namespace -l $SHELL"

    # upgrade $TERM
    set -g default-terminal "screen-256color"

    # emacs key bindings in tmux command prompt (prefix + :) are better than
    # vi keys, even for vim users
    set -g status-keys emacs

### Core key bindings

    # easier and faster switching between next/prev window
    bind C-p previous-window
    bind C-n next-window

Above bindings enhance the default `prefix + p` and `prefix + n` bindings by
allowing you to hold `Ctrl` and repeat `a + p`/`a + n` (if your prefix is
`C-a`), which is a lot quicker.

    # source .tmux.conf as suggested in `man tmux`
    bind R source-file '~/.tmux.conf'

"Adaptable" key bindings that build upon your `prefix` value:

    # if prefix is 'C-a'
    bind C-a send-prefix
    bind a last-window

If prefix is `C-b`, above keys will be `C-b` and `b`.<br/>
If prefix is `C-z`, above keys will be `C-z` and `z`... you get the idea.

### Almost sensible options

Activate these by putting `set -g @almost-sensible 'on'` in `.tmux.conf`.

    # C-a should be the Tmux default prefix, really
    set -g prefix C-a
    set -g mode-keys vi

    # enable mouse features for terminals that support it
    set -g mouse-resize-pane on
    set -g mouse-select-pane on
    set -g mouse-select-window on

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "             \
      tmux-plugins/tpm                \
      tmux-plugins/tmux-sensible      \
    "

Hit `prefix + I` to fetch the plugin and source it. That's it!

You might also want to restart your tmux server, just in case.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-sensible ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/sensible.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You might also want to restart your tmux server, just in case.

### Other goodies

You might also find these useful:

- [copycat](https://github.com/tmux-plugins/tmux-copycat)
  improve tmux search and reduce mouse usage
- [pain control](https://github.com/tmux-plugins/tmux-pain-control)
  useful standard bindings for controlling panes

### License

[MIT](LICENSE.md)