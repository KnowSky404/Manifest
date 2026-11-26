# Tmux Config

- Scope: Linux, WSL, VPS and macOS.
- Real target: `~/.tmux.conf`
- Prerequisites: tmux 3.2+ and the `tmux-256color` terminfo entry. A Nerd Font on the client terminal is recommended for the status icons.
- No third-party plugins required.

The baseline preserves the Catppuccin-style status bar, hostname and local date/time, true color, focus events, extended keys, OSC 52 clipboard support, vi copy mode, mouse support and a 50,000-line history limit.

## Validate before deployment

From the repository root, run as the target user:

```sh
tmux -V
infocmp tmux-256color >/dev/null
(
  set -eu
  conf="$PWD/dotfiles/unix/tmux/.tmux.conf"
  tmp=$(mktemp -d)
  socket="$tmp/tmux.sock"
  trap 'tmux -S "$socket" kill-server >/dev/null 2>&1 || :; rm -rf "$tmp"' EXIT
  tmux -S "$socket" -f /dev/null new-session -d -s validate
  tmux -S "$socket" source-file "$conf"
  tmux -S "$socket" show-options -g status-right
  tmux -S "$socket" show-options -g history-limit
)
```

Check the exit status and any diagnostics. The private socket keeps the test separate from running sessions. This checks configuration loading, not actual terminal capabilities or rendering.

## Apply

Use a reviewed commit from main. Inspect the existing configuration (including symlinks and XDG configuration paths) before replacing it. For a regular file at the default target:

```sh
(
  set -eu
  src=dotfiles/unix/tmux/.tmux.conf
  dst="$HOME/.tmux.conf"
  if [ -L "$dst" ]; then
    echo "Inspect existing tmux.conf symlink before deployment." >&2
    exit 1
  fi
  if [ -f "$dst" ] && cmp -s "$src" "$dst"; then
    exit 0
  fi
  if [ -e "$dst" ]; then
    [ -f "$dst" ] || exit 1
    backup=$(mktemp "$dst.bak.$(date +%Y%m%d-%H%M%S).XXXXXX")
    cp -p "$dst" "$backup"
    printf 'Backup: %s\n' "$backup"
  fi
  cp "$src" "$dst"
)
```

Verify content checksums. For an existing default tmux server, reload without terminating sessions:

```sh
tmux source-file "$HOME/.tmux.conf"
```

Alternatively press Ctrl+B, then r inside tmux. Inspect active custom servers separately; never kill a production tmux server to apply a configuration. Some settings (e.g. history limit and terminal capabilities) may only apply fully to new panes or newly attached clients.

## Key bindings and notes

- Ctrl+B, then r: reload the configuration.
- Ctrl+B, then [: enter copy mode; v starts selection and y copies and exits.
- Ctrl+B twice: send the prefix to a nested tmux with its default prefix.
- Window/pane numbering begins at 1.
- OSC 52 clipboard access is enabled; only use in trusted environments. Actual clipboard behavior depends on the client terminal and intervening tmux/SSH layers.
- True color and extended keys depend on client capabilities. Nerd Font icons may appear as missing glyphs without an appropriate terminal font.
- The right status bar displays the tmux server's local time in YYYY-MM-DD HH:MM format.
- Keep machine-specific secrets and local backups out of this public repository.
- If a host is incompatible, retain its current configuration and report the failure instead of upgrading packages or changing its settings silently.
