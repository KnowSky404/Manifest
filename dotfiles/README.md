# Dotfiles / 配置资产

## Available configurations

The following configurations are currently maintained on the default branch.

| Tool | Platforms | Repository file | Deployment target | Requirements |
| --- | --- | --- | --- | --- |
| Vim | Linux, WSL, macOS / MacVim | [Configuration](unix/vim/.vimrc) · [Guide](unix/vim/README.md) | `~/.vimrc` | Full-featured Vim 9.0+ |
| Tmux | Linux, WSL, macOS | [Configuration](unix/tmux/.tmux.conf) · [Guide](unix/tmux/README.md) | `~/.tmux.conf` | tmux 3.2+, tmux-256color terminfo |

Both configurations are plugin-free. Vim provides a dark theme, cursor highlighting, visual line wrapping, an informative status line, and persistent undo. Tmux provides true-color settings, vi copy mode, mouse support, nested-session compatibility, and a status bar with hostname and local date/time.

---

## 已纳入管理的配置

以下配置目前已在默认分支维护。

| 工具 | 适用平台 | 仓库文件 | 部署路径 | 环境要求 |
| --- | --- | --- | --- | --- |
| Vim | Linux、WSL、macOS / MacVim | [配置文件](unix/vim/.vimrc) · [使用说明](unix/vim/README.md) | `~/.vimrc` | 完整功能版 Vim 9.0+ |
| Tmux | Linux、WSL、macOS | [配置文件](unix/tmux/.tmux.conf) · [使用说明](unix/tmux/README.md) | `~/.tmux.conf` | tmux 3.2+、tmux-256color terminfo |

两套配置均不依赖第三方插件。Vim 提供深色主题、光标高亮、视觉软换行、状态栏及持久化撤销。Tmux 提供真彩色设置、Vi 复制模式、鼠标支持、嵌套会话兼容性，以及显示主机名和本地日期时间的状态栏。
