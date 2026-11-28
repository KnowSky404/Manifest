# Codex Cloud 开发环境规范

[English](CODEX_CLOUD_ENVIRONMENTS.md) | 简体中文

状态：推荐公共基线 · 版本：1.0

本文定义可复用开发环境，不是常驻服务器，也不是 Codex 原生配置文件。Owner 在 ChatGPT 中创建并发布环境；本仓库维护目标规范和可复制提示词。任务分支、风险分级、测试、审查与发布门禁沿用 [AI 原生研发工作流](AI_NATIVE_DEVELOPMENT_WORKFLOW.zh-CN.md)。初始化环境不等于授权修改仓库、合并或部署。

## 环境划分

| 环境 | 建议仓库 | 候选工具链 |
| --- | --- | --- |
| `web-dev` | PureTools、WebTweaks、singdeck、today-eat-what | Bun、按需 Node.js、Git；仅为实际使用的项目准备 Wrangler、Playwright 及浏览器依赖。 |
| `flaremail-dev` | 仅 FlareMail | Bun、兼容的 Node.js、项目本地 Wrangler/Miniflare、按需 SQLite 工具及浏览器测试。 |
| `network-dev` | sing-box-vps、ProxyKit、SubMan、FlareTuner、reality-target-checker（核实实际仓库名称与归属） | 按需 Go、Python、Bun、ShellCheck、shfmt、Bats、jq、yq 及固定版本的 sing-box。 |
| `general-dev` | Manifest 及明确选中的文档、工具仓库 | Git、Bash、jq；按需 Python、Bun、gh、Pandoc、yq、ShellCheck。 |

以上为规划而非实际依赖审计。创建时在仓库选择器核实名称、归属和权限，仅关联明确选中的仓库，不自动扩权。相同技术栈可复用环境，不同凭据或信任边界应隔离。先创建四个环境；桌面原生及小程序专用环境后续按需拆分。

### web-dev

Web 功能、响应式 UI、构建、Lint、类型检查、单元及浏览器测试。小程序仅验证可运行的构建，真机验收及上传在外部完成。

### flaremail-dev

Workers 本地模拟、按实际配置隔离 D1 等绑定、模拟邮件提供方、合成数据、迁移与 API 测试。禁止接入真实邮箱、生产绑定及真实发信。

### network-dev

Shell 测试、配置校验、规则生成、模拟集成。真实 TUN、路由、防火墙、systemd 及特权网络验收转至授权 VPS；不配置真实代理凭据。

### general-dev

Markdown 与链接检查、脚本、Skills、工作流、临时 HOME 下的 Dotfiles 验证。不得执行真实多主机同步、SSH 部署、生产凭证访问或全局配置改动。

## 公共初始化与可复现性

1. 创建环境并选择仓库，在初始化对话中提交对应[提示词](../prompts/codex/cloud-environments/README.md)。读取并记录已审阅的 Manifest 提交 SHA；无法访问时请求提供规范，不得臆造或为此擅自开放全网。
2. 检查各仓库 AGENTS.md、README、版本声明、lockfile、CI、开发与测试命令，记录实际 checkout 路径、SHA、工具版本和命令。遵循项目锁定的版本及包管理器；新兼容工具优先 Bun，但不强制迁移。先复用已有工具，按需从可信来源安装，支持时验证完整性，不执行未经审阅的远程初始化脚本。
3. 配置幂等 Install Script，使用实际路径及锁定依赖安装方式（适用时如 bun install --frozen-lockfile）。安装失败必须显式失败；不自动改写 lockfile、升级依赖、修改项目全局配置或采集秘密。各项目依赖、缓存键、构建及测试可写路径隔离；检查磁盘，仅清理确认可丢弃的产物。
4. 配置 Start Skill：记录各项目依赖新鲜度校验、开发命令、隔离端口与状态、有超时的就绪检查及清理方式。按需启动，不同时启动全部服务；CLI/文档项目无服务则明确记录。仓库刷新不会自动重跑安装和启动命令；首次使用或依赖输入变化时显式检查工具链和依赖，必要时按锁定输入重装，版本不兼容则明确失败。不得假设 Start Skill 自动执行。
5. 验证安装脚本重复执行、各选中项目至少一项代表性构建/检查/测试及适用的服务就绪情况。复用现有命令，记录命令、退出结果、跳过及阻塞事项。实际探测系统、CPU、内存、磁盘与版本，不假设订阅资源上限。不在初始化时执行生产冒烟测试。
6. 审阅配置、脚本、Skill、仓库范围、网络、凭据和私有可见性；保存，由 Owner 执行 Publish。发布后新建任务验证实际环境；初始化会话通过不代表新任务通过。必要验证不能完成时明确报告，由 Owner 决定是否接受，不得自行标记就绪。
7. 更新环境使用 Edit、重测及 Republish，再以新任务验证；已有任务状态独立。重要工作使用 Git 分支和 PR 保存，不依赖 VM 持久化。保存脱敏配置、Manifest SHA、仓库与工具版本、已知限制及手动步骤；只有可移植且脱敏的脚本才可作为公开资产提交。

## 安全与交付边界

- 默认私有，仅启用软件源及有明确理由的目标域名。完整公网、新凭据、外部副作用、提权必须单独授权，不绕过工作区网络策略。
- 禁止生产凭据、私有 SSH 密钥、真实客户或邮箱数据、真实代理节点配置及生产数据库。使用模拟服务、合成数据及隔离测试绑定。确需测试凭据时获得明确授权并限制权限、域名和有效期。兼容的 HTTPS 请求优先 HTTP Secrets；直接环境变量可被程序读取，须谨慎使用。不打印、不固化到镜像、不提交秘密；Manifest 不存放含密钥的文件和日志。
- 使用平台仓库授权，不新增广泛权限 PAT，不擅自扩展仓库范围。审查外部脚本及依赖，不对外部系统执行破坏性操作。
- Cloud 默认仅作为 DEV；不是 PRE/PRO。平台专属的必要测试转至授权 VPS、CI 或本地设备，不因能力缺失而降级门禁或伪造通过。
- 一个任务一个独立范围、分支和 PR，核实目标 SHA，保留无关改动，遵守项目本地指令及审查门禁。环境初始化不授权改代码、合并、发布、真实发信或部署。
- 跨设备交接记录目标、分支/HEAD SHA、验证结果、阻塞与下一步；选择合适的私有或脱敏 PR/Issue，不公开私有运维信息。

## 验收报告

报告环境名称、关联仓库及 SHA、Manifest SHA、实际资源、工具版本、Install Script / Start Skill、逐仓库验证命令与结果、依赖刷新策略、网络白名单理由（不含秘密）、手动操作、未验证能力、当前状态（初始化验证通过 / 阻塞 / 已发布且新任务验证通过）。没有证据不得宣称发布或实测完成。

官方参考：[Cloud environments](https://learn.chatgpt.com/docs/environments/cloud-environments)。产品能力及额度可能变化，依据当期界面和文档核实，不在规范中硬编码账户上限。
