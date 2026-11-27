# Codex — Workflow refactoring / 研发工作流整改

Run Codex in the target repository and submit the prompt in goal mode. Choose one language.

在目标仓库中启动 Codex，以 Goal 模式提交以下任一语言版本。

Canonical standard / 权威规范: [English](../../docs/AI_NATIVE_DEVELOPMENT_WORKFLOW.md) · [简体中文](../../docs/AI_NATIVE_DEVELOPMENT_WORKFLOW.zh-CN.md)

## English

```text
/goal

Read the complete engineering standard at https://github.com/KnowSky404/Manifest/blob/main/docs/AI_NATIVE_DEVELOPMENT_WORKFLOW.md and adapt the current project's development workflow to it.

Reduce repeated testing, reviews, deployments and context consumption. Implement risk classification, automated CI, bounded review cycles and clear completion criteria.

Preserve the existing stack, business behavior, security constraints and authorization boundaries. Record the adopted Manifest commit SHA, implement and verify the changes, and deliver them through a PR rather than only providing recommendations.
```

## 简体中文

```text
/goal

参考 https://github.com/KnowSky404/Manifest/blob/main/docs/AI_NATIVE_DEVELOPMENT_WORKFLOW.md 中的完整工程规范，结合当前项目实际情况，系统性整改并优化现有研发 Workflow。

重点减少重复测试、重复 Review、重复部署和上下文消耗，落实风险分级、自动化 CI、审查收敛机制及任务完成标准。

保留现有技术栈、业务逻辑、安全约束及授权边界，记录所采用的 Manifest Commit SHA，直接实施、验证并通过 PR 交付，而非仅提供建议。
```

This prompt is an adoption entry point, not a substitute for the full standard. Resolve and record the reviewed Manifest revision; retain essential rules locally. Do not infer new deployment or administrative authorization.

该提示词是规范接入入口，不替代完整规范。固定并记录经过审阅的 Manifest 版本，将关键规则落地至目标仓库，不据此推断新的部署或管理授权。
