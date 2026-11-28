# Codex Cloud setup prompts / 云端环境初始化提示词

Choose a profile, select its actual repositories in the Cloud environment picker, and paste one language version into the environment setup conversation (not a CLI /goal task). The Owner reviews and publishes after validation.

选择环境，在 Cloud 环境创建界面关联实际仓库，再复制对应语言版本到初始化对话（不是 CLI /goal 任务）。验收后由 Owner 审阅并发布。

Canonical policy / 权威规范: [English](../../../docs/CODEX_CLOUD_ENVIRONMENTS.md) · [简体中文](../../../docs/CODEX_CLOUD_ENVIRONMENTS.zh-CN.md).

| Profile | Prompt / 提示词 |
| --- | --- |
| `web-dev` | [Open / 打开](web-dev.md) |
| `flaremail-dev` | [Open / 打开](flaremail-dev.md) |
| `network-dev` | [Open / 打开](network-dev.md) |
| `general-dev` | [Open / 打开](general-dev.md) |

Suggested first rollout / 建议首批顺序: general-dev → web-dev → flaremail-dev → network-dev.

Use reviewed main or an explicit reviewed commit; record the SHA. If the document is inaccessible, attach its contents manually. Do not grant broader permissions just to fetch it.

使用已审阅的 main 或指定提交并记录 SHA。无法读取时手动提供规范，不为下载而扩大权限。
