# Manifest

**个人数字工作环境的唯一可信来源（Single Source of Truth）**

[English](README.md) | 简体中文

Manifest 是用于集中管理个人开发环境及工程规范资产的仓库，涵盖版本化的 Dotfiles 配置、系统重装后的恢复清单、常用软件清单及数据备份指引。目标是让工作站和服务器的环境重建更加可预测、高效且安全。

项目源于一次依赖供应链安全事件及随后的系统重装。其核心理念是：**环境即资产**。

## 已纳入管理的配置

以下配置目前已在默认分支维护。

| 工具 | 适用平台 | 仓库文件 | 部署路径 | 环境要求 |
| --- | --- | --- | --- | --- |
| Vim | Linux、WSL、macOS / MacVim | [配置文件](dotfiles/unix/vim/.vimrc) · [使用说明](dotfiles/unix/vim/README.md) | `~/.vimrc` | 完整功能版 Vim 9.0+ |
| Tmux | Linux、WSL、macOS | [配置文件](dotfiles/unix/tmux/.tmux.conf) · [使用说明](dotfiles/unix/tmux/README.md) | `~/.tmux.conf` | tmux 3.2+、tmux-256color terminfo |

两套配置均不依赖第三方插件。Vim 提供深色主题、光标高亮、视觉软换行、状态栏及持久化撤销。Tmux 提供真彩色设置、Vi 复制模式、鼠标支持、嵌套会话兼容性，以及显示主机名和本地日期时间的状态栏。

## 工程规范

- [AI 原生研发工作流规范](docs/AI_NATIVE_DEVELOPMENT_WORKFLOW.zh-CN.md)（[English](docs/AI_NATIVE_DEVELOPMENT_WORKFLOW.md)）：可复用的风险分级、CI、审查、候选验收、发布及代理上下文管理规则。按目标项目适配，记录接入版本，并保留本地关键规范。

### 接入现有项目

在目标项目仓库中启动 Codex，使用 Goal 模式提交以下通用提示词：

```text
/goal

参考 https://github.com/KnowSky404/Manifest/blob/main/docs/AI_NATIVE_DEVELOPMENT_WORKFLOW.md 中的完整工程规范，结合当前项目实际情况，系统性整改并优化现有研发 Workflow。

重点减少重复测试、重复 Review、重复部署和上下文消耗，落实风险分级、自动化 CI、审查收敛机制及任务完成标准。

保留现有技术栈、业务逻辑、安全约束及授权边界，记录所采用的 Manifest Commit SHA，直接实施、验证并通过 PR 交付，而非仅提供建议。
```

该提示词是规范接入入口，不替代完整规范。读取并固定经过审阅的规范版本，将关键规则落地到目标仓库。其他导航见 [Wiki](https://github.com/KnowSky404/Manifest/wiki)。

## 快速开始

克隆仓库，并在安装任何配置之前阅读对应工具的使用说明：

```sh
git clone https://github.com/KnowSky404/Manifest.git
cd Manifest
git rev-parse HEAD
```

以经过审阅的 `main` 分支作为部署来源。根据 [Vim 使用说明](dotfiles/unix/vim/README.md) 或 [Tmux 使用说明](dotfiles/unix/tmux/README.md)，先验证候选配置、备份现有文件，再为目标用户安装。不要直接覆盖已有配置或符号链接。

## 多主机同步

Manifest 定义目标配置，Git 记录版本历史，Hermes 等外部部署代理负责将配置应用至已授权管理的主机。

- 每个部署批次使用同一个经过审阅的 Git 提交。
- 检查平台、目标用户、软件版本和配置路径。
- 比较文件校验值，跳过内容一致的文件。
- 验证候选配置，备份现有文件，完成部署并校验结果。
- 部署失败时回滚，并记录各主机执行结果。
- 重新加载运行中的 Tmux 服务时不得销毁会话，不中断正在执行的开发任务。

当前仓库提供配置文件和手动部署说明，尚未内置配置同步服务。定时检查与远程部署由外部代理负责。

## 仓库结构

当前 `main` 分支结构：

```text
.
├── docs/
│   ├── AI_NATIVE_DEVELOPMENT_WORKFLOW.md
│   └── AI_NATIVE_DEVELOPMENT_WORKFLOW.zh-CN.md
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

## 后续规划

原有项目架构保留在 [repo-structure 分支](https://github.com/KnowSky404/Manifest/tree/repo-structure)。以下为规划中的目录职责，不代表相关功能已在 `main` 实现。

| 目录 | 规划用途 |
| --- | --- |
| `docs/` | 工程规范（已提供研发工作流）、架构及恢复流程 |
| `dotfiles/shared/` | 跨平台配置，例如 Git 和 SSH 模板 |
| `dotfiles/unix/` | Linux、WSL、macOS 配置 |
| `dotfiles/windows/` | Windows 配置 |
| `restore/` | 系统恢复清单及平台专属指引 |
| `apps/` | 软件清单及安装参考 |
| `data-manifest/` | 数据资产清单及备份恢复说明 |
| `secrets-template/` | 仅存放脱敏模板，不包含真实凭证 |
| `scripts/` | 环境初始化与配置校验自动化 |

后续将完善原有目录架构、扩展配置资产、补充软件安装清单，并实现可重复执行的初始化与校验流程。

## 维护与安全规范

- 每个工具独立目录，包含配置文件及部署说明。
- 每个独立变更使用专用分支和 PR，审阅后合并至 `main`。
- 优先使用可移植的默认配置，并记录平台专属例外。
- 凭证、私钥、Token、敏感主机信息、本地备份及编辑器撤销数据均不得提交至本公开仓库。
- 部署前审阅配置变更；同步过程中不得擅自升级软件或修改系统级配置。

## 开源协议

[GNU Affero General Public License v3.0](LICENSE)。
