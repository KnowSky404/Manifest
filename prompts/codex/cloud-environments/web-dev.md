# web-dev — initialization / 初始化

Paste one language block into the Cloud environment setup conversation. Select actual repositories first. / 先关联实际仓库，再复制任一语言版本至 Cloud 初始化对话。

## English

```text
Configure this Codex Cloud Environment as web-dev following the complete reviewed Manifest policy:
https://github.com/KnowSky404/Manifest/blob/main/docs/CODEX_CLOUD_ENVIRONMENTS.md

Suggested repositories: PureTools, WebTweaks, singdeck, today-eat-what. Work only with repositories I selected; report missing access rather than expanding it.
Candidate tools: Bun, Node.js (when needed), Git; Wrangler and Playwright/browser dependencies only for projects that use them.
Scope: Web development, UI and responsive layout, build/lint/type checks, unit and browser tests. WeChat builds where supported; device validation and upload remain external.

Read and record the reviewed Manifest SHA. Inspect each repository's instructions, lockfiles, runtime declarations, CI and tests; preserve its toolchain and package manager. Install only necessary tools. Configure and test an idempotent Install script and a per-project Start skill with explicit dependency refresh checks, on-demand startup, readiness checks and cleanup. Keep projects' writable state separate. Run representative checks for every selected repository and record actual commands/results, tool versions, resources, network requirements, blockers and manual steps.

Keep the environment private, restrict network access, use synthetic data, do not configure production credentials, modify repositories, merge, deploy or bypass required gates. If the policy cannot be read, ask me to provide it. Save the tested configuration for my review before Publish; do not publish without my approval. Provide a fresh-task verification checklist.
```

## 简体中文

```text
请将当前 Codex Cloud Environment 初始化为 web-dev，完整遵循已审阅的 Manifest 规范：
https://github.com/KnowSky404/Manifest/blob/main/docs/CODEX_CLOUD_ENVIRONMENTS.zh-CN.md

建议仓库：PureTools、WebTweaks、singdeck、today-eat-what。仅处理我在界面中实际选中的仓库；权限缺失时报告，不擅自扩权。
候选工具链：Bun、按需 Node.js、Git；仅为实际使用的项目准备 Wrangler、Playwright 及浏览器依赖。
环境职责：Web 功能、响应式 UI、构建、Lint、类型检查、单元及浏览器测试。小程序仅验证可运行的构建，真机验收及上传在外部完成。

读取并记录已审阅的 Manifest Commit SHA，检查各仓库 AGENTS.md、依赖锁文件、版本声明、CI 与测试，保留现有技术栈和包管理器，仅安装必要工具。配置并验证幂等 Install Script 与逐项目 Start Skill，显式处理仓库刷新后的依赖校验、按需服务启动、就绪检查和清理，隔离各项目可写状态。逐仓库运行代表性验证，报告实际命令及结果、工具版本、资源、网络需求、阻塞事项和手动步骤。

环境保持私有，网络最小权限，使用合成数据，不配置生产凭据，不修改业务仓库、不合并、不部署、不绕过必要门禁。规范无法读取时请我提供。保存已验证配置供我审阅，未经确认不得 Publish；同时提供发布后新任务验收清单。
```
