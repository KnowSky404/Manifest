# network-dev — initialization / 初始化

Paste one language block into the Cloud environment setup conversation. Select actual repositories first. / 先关联实际仓库，再复制任一语言版本至 Cloud 初始化对话。

## English

```text
Configure this Codex Cloud Environment as network-dev following the complete reviewed Manifest policy:
https://github.com/KnowSky404/Manifest/blob/main/docs/CODEX_CLOUD_ENVIRONMENTS.md

Suggested repositories: sing-box-vps, ProxyKit, SubMan, FlareTuner, reality-target-checker (verify canonical repository names/owners). Work only with repositories I selected; report missing access rather than expanding it.
Candidate tools: Go, Python, Bun, ShellCheck, shfmt, Bats, jq, yq and a pinned sing-box binary only as required.
Scope: Shell tests, configuration validation, rule generation, mock integrations. Real TUN, routing, firewall, systemd and privileged networking acceptance belongs on an authorized VPS; no live proxy credentials.

Read and record the reviewed Manifest SHA. Inspect each repository's instructions, lockfiles, runtime declarations, CI and tests; preserve its toolchain and package manager. Install only necessary tools. Configure and test an idempotent Install script and a per-project Start skill with explicit dependency refresh checks, on-demand startup, readiness checks and cleanup. Keep projects' writable state separate. Run representative checks for every selected repository and record actual commands/results, tool versions, resources, network requirements, blockers and manual steps.

Apply the common and profile-specific variable guide from the same reviewed Manifest revision: https://github.com/KnowSky404/Manifest/blob/main/docs/CODEX_CLOUD_ENVIRONMENT_VARIABLES.md
Audit example env files, runtime reads, CI and project config. Apply only safe applicable non-sensitive values; prefer ignored project-local config over duplicated global values. Leave HTTP secrets empty initially; list any required manual settings, scope, allowed hosts and least privilege without exposing secret values. Validate operation without optional credentials.

Keep the environment private, restrict network access, use synthetic data, do not configure production credentials, modify repositories, merge, deploy or bypass required gates. If the policy cannot be read, ask me to provide it. Save the tested configuration for my review before Publish; do not publish without my approval. Provide a fresh-task verification checklist.
```

## 简体中文

```text
请将当前 Codex Cloud Environment 初始化为 network-dev，完整遵循已审阅的 Manifest 规范：
https://github.com/KnowSky404/Manifest/blob/main/docs/CODEX_CLOUD_ENVIRONMENTS.zh-CN.md

建议仓库：sing-box-vps、ProxyKit、SubMan、FlareTuner、reality-target-checker（核实实际仓库名称与归属）。仅处理我在界面中实际选中的仓库；权限缺失时报告，不擅自扩权。
候选工具链：按需 Go、Python、Bun、ShellCheck、shfmt、Bats、jq、yq 及固定版本的 sing-box。
环境职责：Shell 测试、配置校验、规则生成、模拟集成。真实 TUN、路由、防火墙、systemd 及特权网络验收转至授权 VPS；不配置真实代理凭据。

读取并记录已审阅的 Manifest Commit SHA，检查各仓库 AGENTS.md、依赖锁文件、版本声明、CI 与测试，保留现有技术栈和包管理器，仅安装必要工具。配置并验证幂等 Install Script 与逐项目 Start Skill，显式处理仓库刷新后的依赖校验、按需服务启动、就绪检查和清理，隔离各项目可写状态。逐仓库运行代表性验证，报告实际命令及结果、工具版本、资源、网络需求、阻塞事项和手动步骤。

读取同一已审阅 Manifest 版本中的通用及本环境专属变量规范：https://github.com/KnowSky404/Manifest/blob/main/docs/CODEX_CLOUD_ENVIRONMENT_VARIABLES.zh-CN.md
检查示例 env 文件、实际读取逻辑、CI 及项目配置，仅设置安全且适用的非敏感值，优先使用忽略的项目本地配置而非重复全局变量。HTTP Secrets 初始留空；列出必要的人工配置、作用域、允许域名及最小权限，不暴露秘密值。验证缺少可选凭据时仍可正常开发。

环境保持私有，网络最小权限，使用合成数据，不配置生产凭据，不修改业务仓库、不合并、不部署、不绕过必要门禁。规范无法读取时请我提供。保存已验证配置供我审阅，未经确认不得 Publish；同时提供发布后新任务验收清单。
```
