# Manifest

**The Single Source of Truth for My Digital Workspace**

English | [简体中文](README.zh-CN.md)

Manifest is a centralized repository for personal development environment assets: version-controlled dotfiles, system recovery checklists, software inventories, and backup instructions. Its goal is to make rebuilding a workstation or server predictable, efficient, and secure.

The project was motivated by a dependency supply-chain incident that required a system reinstall. The underlying principle is simple: **the environment itself is an asset**.

## Available configurations

The following configurations are currently maintained on the default branch.

| Tool | Platforms | Repository file | Deployment target | Requirements |
| --- | --- | --- | --- | --- |
| Vim | Linux, WSL, macOS / MacVim | [Configuration](dotfiles/unix/vim/.vimrc) · [Guide](dotfiles/unix/vim/README.md) | `~/.vimrc` | Full-featured Vim 9.0+ |
| Tmux | Linux, WSL, macOS | [Configuration](dotfiles/unix/tmux/.tmux.conf) · [Guide](dotfiles/unix/tmux/README.md) | `~/.tmux.conf` | tmux 3.2+, tmux-256color terminfo |

Both configurations are plugin-free. Vim provides a dark theme, cursor highlighting, visual line wrapping, an informative status line, and persistent undo. Tmux provides true-color settings, vi copy mode, mouse support, nested-session compatibility, and a status bar with hostname and local date/time.

## Quick start

Clone the repository and review the tool-specific guides before installing any configuration:

```sh
git clone https://github.com/KnowSky404/Manifest.git
cd Manifest
git rev-parse HEAD
```

Use the reviewed `main` branch as the deployment source. Follow the [Vim guide](dotfiles/unix/vim/README.md) or [Tmux guide](dotfiles/unix/tmux/README.md) to validate the candidate configuration, back up existing files, and install it for the intended user. Do not blindly overwrite existing configurations or symlinks.

## Multi-host synchronization

Manifest defines the desired configuration; Git tracks its history; deployment agents such as Hermes apply it to authorized hosts.

- Resolve a single reviewed commit for each deployment batch.
- Check platform, user, tool version, and configuration paths.
- Compare file checksums and skip unchanged files.
- Validate candidates, back up existing files, deploy, and verify the result.
- Roll back failed deployments and record per-host results.
- Reload running tmux servers without destroying sessions. Do not interrupt running development tasks.

The repository currently provides configuration files and manual deployment guides, not a built-in synchronization service. Scheduled checks and remote deployments are the responsibility of the external agent.

## Repository layout

Current structure on `main`:

```text
.
├── dotfiles/
│   └── unix/
│       ├── tmux/
│       │   ├── .tmux.conf
│       │   └── README.md
│       └── vim/
│           ├── .vimrc
│           └── README.md
├── LICENSE
├── README.md
└── README.zh-CN.md
```

## Roadmap

The original architecture is retained in the [repo-structure branch](https://github.com/KnowSky404/Manifest/tree/repo-structure). The following areas describe the intended structure, not features already implemented on `main`.

| Directory | Intended purpose |
| --- | --- |
| `docs/` | Conventions, architecture, and recovery procedures |
| `dotfiles/shared/` | Cross-platform configuration, such as Git and SSH templates |
| `dotfiles/unix/` | Linux, WSL, and macOS configuration |
| `dotfiles/windows/` | Windows configuration |
| `restore/` | System recovery checklists and platform-specific instructions |
| `apps/` | Software inventories and installation references |
| `data-manifest/` | Data inventory and backup/recovery instructions |
| `secrets-template/` | Sanitized templates only; no live secrets |
| `scripts/` | Bootstrap and validation automation |

Future work includes restoring the planned structure, expanding the configuration inventory, documenting package installation, and implementing repeatable bootstrap and validation workflows.

## Maintenance and security

- Keep one directory per tool, with its configuration and deployment guide.
- Use a dedicated branch and pull request for each focused change; merge reviewed content into `main`.
- Prefer portable defaults and documented platform-specific exceptions.
- Keep credentials, private keys, tokens, sensitive host details, local backups, and editor undo data outside this public repository.
- Review configuration changes before deployment. Do not upgrade software or change system-wide settings as a side effect of synchronization.

## License

[GNU Affero General Public License v3.0](LICENSE).
