# Codex Cloud 环境变量与凭据规范

[English](CODEX_CLOUD_ENVIRONMENT_VARIABLES.md) | 简体中文

状态：推荐公共配置 · 版本：1.0

本文配合 [Cloud 环境基线](CODEX_CLOUD_ENVIRONMENTS.zh-CN.md) 使用。以下是推荐值，而非 Codex 原生配置文件，也不是各仓库完整变量清单。不要将整篇文档粘贴至变量编辑器；先核实当前项目契约、工作区限制和实际运行环境。

## 配置分层

| 位置 | 用途 |
| --- | --- |
| Environment variables | 当前环境中程序直接读取的非敏感配置 |
| Personal vault | 环境声明请求的个人值；无害通用偏好可选 All environments，其余使用 Selected environments |
| 项目本地配置 | 由已审阅示例生成 Git 忽略的 .env/.dev.vars，或命令级变量 |
| HTTP Secrets | 单独授权的测试 HTTPS 凭据，限定目标域名 |
| GitHub Actions / 授权发布系统 | 生产凭据和发布配置，不迁入 Cloud DEV |

Personal vault 仅向请求对应 Key 的环境注入值，指定环境的个人值优先于个人通用值。除明确记录的覆盖关系外，不重复定义同一 Key；实际 dotenv 优先级按项目验证，不作统一假设。直接变量与 HTTP Secret 不得使用相同 Key。

## 四套环境通用变量

建议设置为普通变量，或使用环境已请求的 Personal vault 值。保留平台管理的配置；项目及测试明确要求优先。

| Key | 建议值 | 条件 |
| --- | --- | --- |
| TZ | Asia/Shanghai | 交互与日志时区偏好；UTC 或时区敏感测试按需覆盖 |
| LANG | C.UTF-8 | 确认系统支持，不支持则保留默认 |
| EDITOR | vim | 可选，已安装才设置 |
| VISUAL | vim | 可选，已安装才设置 |
| GIT_PAGER | cat | 可选，避免非交互 Git 分页 |
| PIP_DISABLE_PIP_VERSION_CHECK | 1 | 使用 pip 时可选 |
| NO_UPDATE_NOTIFIER | 1 | 兼容 CLI 工具可选，不替代安全更新策略 |

Cloud UI 最小推荐项为 TZ 和系统支持的 LANG，其余偏好无需全量设置。不要全局覆盖 CI=true、NODE_ENV、LC_ALL、PATH、CODEX_HOME、HTTP_PROXY、HTTPS_PROXY、ALL_PROXY 或 NO_PROXY；确有需要按命令配置且不得绕过网络控制。Codex 自身无需 OPENAI_API_KEY。

## 各环境专属变量

### web-dev

| Key | 建议值 | 位置 / 用途 |
| --- | --- | --- |
| WRANGLER_SEND_METRICS | false | 使用 Wrangler 时配置在环境级 |
| PUBLIC_BASE_PATH | 本地开发为 / | 仅 today-eat-what，项目内配置；目标构建按实际路径调整 |
| TARO_APP_ID | 初始留空 | 仅 today-eat-what，必要时由 Owner 提供授权 AppID |
| WEAPP_DESC | 初始留空 | 可选版本备注，不影响普通开发 |
| PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD | 不设置 | 遵循项目浏览器安装流程，不跳过必要下载 |

抽查配置暂未发现 PureTools、WebTweaks、singdeck 必须额外填写的 Cloud UI 变量；仍需核实源码读取逻辑。接口测试使用本地合成数据。不要迁入 WEAPP_PRIVATE_KEY_PATH 或对应上传/签名私钥；需要真实授权的预览上传在外部完成。

### flaremail-dev

使用 Wrangler 时环境级设置 WRANGLER_SEND_METRICS=false。优先根据 FlareMail 的 [.dev.vars.example](https://github.com/KnowSky404/FlareMail/blob/main/.dev.vars.example) 生成 Git 忽略的任务本地 .dev.vars，而非在 Cloud UI 重复配置。先核实实际运行时及本地认证初始化逻辑，不接入真实账户及远程绑定。

| Key | 本地示例值 | 用途 |
| --- | --- | --- |
| APP_ENV | development | DEV |
| ALLOW_FAKE_SERVICES | true | 本地模拟服务 |
| OUTBOUND_PROVIDER | demo | 仅模拟发信 |
| AUTH_MODE | local | 本地认证 |
| TELEGRAM_ENABLED | false | 不接入真实 Bot |
| AUTO_REPLY_ENABLED | true | 仓库示例，仅在模拟发信得到验证后启用 |
| INBOUND_NOTIFICATION_ENABLED | true | 仓库示例，仅在隔离模拟通知得到验证后启用 |
| APP_BASE_URL | http://127.0.0.1:8787 | 按实际本地服务端口调整 |

以上为仓库示例而非完整变量契约。必须核实无真实发信、通知、外部 API 或生产存储副作用；不能证明模拟交付时关闭自动回复和通知。使用临时本地数据、合成身份，按授权执行本地迁移和认证初始化。含凭据的忽略文件在支持时使用 0600 权限，不将真实凭据或私有邮箱固化进发布文件系统。

### network-dev

| Key | 建议值 | 位置 / 用途 |
| --- | --- | --- |
| WRANGLER_SEND_METRICS | false | 关联 SubMan 等 Wrangler 项目时环境级配置 |
| GOTOOLCHAIN | 项目声明或默认 | 遵循 go.mod 与 CI，不全局覆盖 |
| GOPROXY | 默认 | 无明确需要不硬编码镜像 |
| SINGBOX_BINARY_114 | 实际验证的二进制路径 | 当前测试契约需要时，仅 sing-box-vps 测试命令 |
| SINGBOX_BINARY_113 | 实际验证路径或不设置 | 仅当前兼容性测试需要时使用 |

按当前仓库测试与 CI 确认路径和版本，不假设宿主机路径；带版本后缀的变量是已观察到的示例，不保证永久不变。不导入真实代理订阅、节点凭据、SSH 私钥及生产 Cloudflare 绑定；特权网络测试留在授权测试主机。

### general-dev

按需使用通用变量，无额外必填的项目专属 Cloud UI 变量。验证 Dotfiles 时按测试设置临时 HOME/XDG 路径，不全局覆盖 Cloud 管理的 HOME 或改变真实主机配置。HTTP Secrets 初始留空。

## 凭据与网络策略

所有环境初始 HTTP Secrets 为空。仅为已记录且单独授权的测试需求添加凭据；API 可调用不代表具备执行操作的授权。

| 候选 Key | Allowed domains | 适用范围 / 用途 |
| --- | --- | --- |
| CLOUDFLARE_EMAIL_ROUTING_READ_TOKEN | api.cloudflare.com | flaremail-dev，测试域邮件路由只读 |
| RESEND_API_KEY | api.resend.com | flaremail-dev，隔离测试账号/域；真实发信另行授权 |
| CLOUDFLARE_API_TOKEN | api.cloudflare.com | 独立测试资源，禁止生产及部署 Token |
| OPENAI_API_KEY | api.openai.com | AI 应用接口测试可选，不是 Codex 认证 |
| DEEPSEEK_API_KEY | api.deepseek.com | AI 应用接口测试可选 |
| GH_TOKEN 或 GITHUB_TOKEN | api.github.com | 平台仓库授权不足且另行批准时才使用，优先最小授权 |

以上为候选名，不是必填项，也不保证客户端兼容 HTTP Secret 替换。确认实际客户端 Key、目标地址及兼容性。公开文件中禁止广泛权限 PAT、真实 Telegram Token、Webhook/HMAC 签名秘密及私钥。需要在本地读取原始值进行签名或加密的凭据不适用 HTTP 替换；优先模拟，确需真实测试凭据时单独授权，使用限制范围的直接秘密且不持久化。禁止打印秘密、完整 env dump，以及将秘密写入日志、截图、PR、镜像或准备好的文件系统快照。

HTTP Secrets 向程序提供占位符，通过代理在兼容的 HTTPS 443 请求中替换。直接变量与 HTTP Secrets 的 Key 必须不同。环境自有 HTTP Secrets 会同时开放对应域名；Personal vault 值及普通变量不会自动开放域名，保存后复核实际网络策略。默认关闭完整公网、按需开启软件源域名、仅添加有理由的额外域名、保持私有，不默认配置 VPN/OIDC。

## 初始化与更新验收

1. 检查各选中仓库 AGENTS.md、示例 env 文件、Wrangler/运行时配置、脚本、CI 及实际变量读取逻辑；区分必填、可选及消费者，不能将本文视为穷尽清单。
2. 核对通用推荐与已有环境设置，保留 Owner 的有意覆盖及项目行为。可通过初始化对话或 UI 配置的安全值直接配置，否则提供准确 Key/Value 及手动步骤。避免重复及无用变量。
3. 根据已审阅模板生成忽略的本地配置，验证优先级、本地绑定、模拟凭据及缺少可选密钥时的行为；不顺带修改业务仓库。
4. 输出 Key、非敏感示例/默认值（或未设置）、作用域、必填/可选、消费者、配置状态及适用的域名、最小权限。秘密只报告是否配置，不输出值；记录人工操作和未验证路径。
5. 使用生效配置运行代表性验证，必要时证明外部副作用仅为模拟，检查准备好的文件，由 Owner 发布/重新发布，再用新任务验证。缺少必要凭据或测试是阻塞，不得标记通过。

参考：[Cloud 官方配置文档](https://learn.chatgpt.com/docs/environments/cloud-environments)、[today-eat-what 示例](https://github.com/KnowSky404/today-eat-what/blob/main/.env.example)、[sing-box-vps CI 契约](https://github.com/KnowSky404/sing-box-vps/blob/main/.github/workflows/command-contract.yml)、[SubMan 部署工作流](https://github.com/KnowSky404/SubMan/blob/main/.github/workflows/deploy.yml)。仓库示例来自抽查而非完整审计，初始化时应重新核实已审阅版本。
