# Manifest: The Single Source of Truth for My Digital Workspace

这是一个用于管理个人开发环境资产的中心化仓库。它不仅包含了跨平台的配置文件（Dotfiles），还记录了系统重装后的恢复清单、常用软件集以及关键数据的备份指引。

为什么会有这个仓库？
在经历了一次由于依赖投毒导致的安全事件和系统重装后，我意识到“环境即资产”。这个仓库旨在确保在任何硬件环境下，都能通过标准化的清单和脚本，在最短时间内实现开发环境的高效率、高安全性复原。

## Directory Layout

```text
.
├── docs/
├── dotfiles/
├── restore/
├── apps/
├── data-manifest/
├── secrets-template/
└── scripts/
```

## How To Use This Repo

- `dotfiles/` 保存配置文件本体或脱敏模板。
- `restore/` 记录系统重装后的恢复顺序和平台说明。
- `apps/` 记录软件清单和安装理由。
- `data-manifest/` 记录必须备份或导出的重要数据。
- `secrets-template/` 只保留敏感信息模板和说明，不存真实内容。
- `scripts/` 为后续自动化恢复和校验预留。

## Starting Point

If you are populating the repository for the first time:

1. Put shared configs in `dotfiles/shared/`.
2. Put Unix-specific configs in `dotfiles/unix/`.
3. Put Windows-specific configs in `dotfiles/windows/`.
4. Fill `restore/common/` before writing platform-specific reinstall notes.
5. Fill `data-manifest/` before the next OS reinstall.
