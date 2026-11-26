# Vim Config

- Scope: Linux, WSL, and macOS (including MacVim).
- Real target: ~/.vimrc
- Prerequisites: full-featured Vim 9.0+ or MacVim; no third-party plugins.

This is the portable configuration baseline: dark habamax theme (desert fallback), line numbers, cursor row/column highlighting, visual wrapping, encoding and line-ending status, search, filetype indentation and persistent undo.

## Apply

From the repository root, as the intended user (not with sudo):

```sh
vim --version
vim -Nu "$PWD/dotfiles/unix/vim/.vimrc" -i NONE -n -es -c 'qa!'
```

Proceed only if the validation command exits successfully. If ~/.vimrc is a symlink, inspect it and decide whether to update its target or replace the link before proceeding. For a regular file, the following commands back up changes and skip an identical configuration:

```sh
(
  set -eu
  src=dotfiles/unix/vim/.vimrc
  dst="$HOME/.vimrc"
  if [ -L "$dst" ]; then
    echo "Inspect existing vimrc symlink before deployment." >&2
    exit 1
  fi
  if [ -f "$dst" ] && cmp -s "$src" "$dst"; then
    exit 0
  fi
  if [ -e "$dst" ]; then
    [ -f "$dst" ] || exit 1
    backup=$(mktemp "$dst.bak.$(date +%Y%m%d-%H%M%S).XXXXXX")
    cp -p "$dst" "$backup"
    printf 'Backup: %s
' "$backup"
  fi
  cp "$src" "$dst"
)
```

Restart Vim (and MacVim, if used). Check the active settings:

```vim
:set number? cursorline? cursorcolumn? wrap? linebreak? breakindent?
:set swapfile? undofile? undodir? laststatus?
:set fileencoding? fileformat?
:colorscheme
```

## Key bindings

The default leader is backslash.

- w: toggle visual wrapping.
- c: toggle cursor column highlighting.
- : toggle relative line numbers.
- l: toggle visible whitespace.
- h: clear search highlighting.
- gj / gk: move by displayed lines (native Vim commands).

## Notes

- Visual wrapping does not change physical file lines. Filetype plugins may override automatic formatting options.
- Swap files are disabled; unsaved edits cannot be recovered using swap after a crash, and concurrent editing warnings are reduced.
- Persistent undo is stored locally under ~/.vim/undo when supported. It is not a substitute for crash recovery and may contain sensitive historical text. Never commit undo files or local backups; disable persistent undo before editing sensitive data if needed.
- Keep machine-specific data and credentials outside this public repository.
- MacVim may also load ~/.gvimrc, which can override display settings; inspect it if the UI differs.
- Multi-host deployment should use a reviewed commit, verify SHA-256, preserve backups, and report validation failures rather than modifying unrelated settings.
