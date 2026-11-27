# Manifest

**The Single Source of Truth for My Digital Workspace**

English | [简体中文](README.zh-CN.md)

Manifest is a centralized repository for personal development environment and engineering assets: version-controlled dotfiles, system recovery checklists, software inventories, and backup instructions. Its goal is to make rebuilding a workstation or server predictable, efficient, and secure.

The project was motivated by a dependency supply-chain incident that required a system reinstall. The underlying principle is simple: **the environment itself is an asset**.

## Asset index

| Category | Purpose |
| --- | --- |
| [Dotfiles](dotfiles/README.md) | Portable development environment configurations and installation guides |
| [Engineering standards](docs/README.md) | Versioned policies and engineering conventions |
| [Prompt library](prompts/README.md) | Reusable AI task prompts, including Codex workflow adoption |
| [Wiki](https://github.com/KnowSky404/Manifest/wiki) | Supplementary knowledge base and navigation |

## Quick start

Clone the repository and review the tool-specific guides before installing any configuration:

```sh
git clone https://github.com/KnowSky404/Manifest.git
cd Manifest
git rev-parse HEAD
```

Use the reviewed `main` branch as the deployment source. Follow the relevant [configuration guide](dotfiles/README.md) to validate the candidate, back up existing files, and install for the intended user. Do not blindly overwrite existing configurations or symlinks.

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

Top-level structure (see category indexes for individual assets):

```text
.
├── docs/
├── dotfiles/
├── prompts/
├── LICENSE
├── README.md
└── README.zh-CN.md
```

## Roadmap

The original architecture is retained in the [repo-structure branch](https://github.com/KnowSky404/Manifest/tree/repo-structure). The following areas describe the intended structure; some are already available in the asset index.

| Directory | Intended purpose |
| --- | --- |
| `docs/` | Engineering standards (initial workflow available), architecture, and recovery procedures |
| `prompts/` | Reusable AI prompts, organized by tool or task |
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
