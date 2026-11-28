# Codex Cloud environment baseline

English | [简体中文](CODEX_CLOUD_ENVIRONMENTS.zh-CN.md)

Status: recommended shared baseline · Version: 1.0

This standard defines reusable development environments, not always-on hosts or a native Codex configuration format. The Owner creates and publishes environments in ChatGPT; this repository records desired policy and copyable prompts. Follow the [AI-Native Development Workflow](AI_NATIVE_DEVELOPMENT_WORKFLOW.md) for task branches, risk-based checks, review and release gates. Environment setup is not authorization to modify repositories, merge or deploy.

## Profiles

| Environment | Suggested repositories | Candidate tooling |
| --- | --- | --- |
| `web-dev` | PureTools, WebTweaks, singdeck, today-eat-what | Bun, Node.js (when needed), Git; Wrangler and Playwright/browser dependencies only for projects that use them. |
| `flaremail-dev` | FlareMail only | Bun, compatible Node.js, project-local Wrangler/Miniflare, SQLite tooling and browser tests as required. |
| `network-dev` | sing-box-vps, ProxyKit, SubMan, FlareTuner, reality-target-checker (verify canonical repository names/owners) | Go, Python, Bun, ShellCheck, shfmt, Bats, jq, yq and a pinned sing-box binary only as required. |
| `general-dev` | Manifest and explicitly selected documentation/tooling repositories | Git, Bash, jq; Python, Bun, gh, Pandoc, yq and ShellCheck when needed. |

These are suggested assignments, not an audited inventory. Confirm repository access and canonical names in the picker; attach only the selected repositories. Do not automatically grant access to additional repositories. Prefer shared environments for compatible stacks and separate environments for distinct credentials/trust boundaries. Start with these four; split desktop/native or WeChat tooling later if justified.

### web-dev

Web development, UI and responsive layout, build/lint/type checks, unit and browser tests. WeChat builds where supported; device validation and upload remain external.

### flaremail-dev

Workers local emulation, isolated D1/other bindings if applicable, fake mail providers, synthetic data, migration and API tests. No live mailbox, production bindings or real email sending.

### network-dev

Shell tests, configuration validation, rule generation, mock integrations. Real TUN, routing, firewall, systemd and privileged networking acceptance belongs on an authorized VPS; no live proxy credentials.

### general-dev

Markdown/link checks, scripts, skills, workflow and dotfile validation using temporary homes. No real multi-host sync, SSH deployment, production secrets or global configuration changes.

## Common setup and reproducibility

1. Select repositories in Cloud environment creation; use the profile's [setup prompt](../prompts/codex/cloud-environments/README.md) in the setup conversation. Read the reviewed Manifest revision and record its SHA. If inaccessible, request the document rather than invent policy or enable broad network access.
2. Inspect each checkout's AGENTS.md, README, version declarations, lockfiles, CI and dev/test commands. Record checkout paths, commit SHAs, supported runtime versions and commands. Follow repository-defined versions and package managers; prefer Bun for new compatible tooling, not a forced migration. Use existing tools first, install only missing dependencies from trusted sources, verify integrity when supported; never run an unreviewed remote bootstrap.
3. Configure an idempotent Install script using actual checkout paths and locked dependency installation (e.g. bun install --frozen-lockfile when appropriate). Fail on installation errors; no automatic lockfile rewrite, dependency upgrade, global project configuration change or secret capture. Keep separate project dependencies, cache keys and writable build/test paths. Measure disk use; remove only known disposable artifacts.
4. Configure the Start skill with per-repository dependency freshness checks, documented dev commands, isolated ports/state, bounded readiness probes and cleanup. Start services on demand, not all at once. For CLI/docs-only repos, record that no service is needed. Repository refresh does not rerun setup/start commands; explicitly recheck tool versions and dependency inputs before first use and after changes, reinstall with frozen inputs when needed, and fail clearly on incompatible versions. Do not assume the Start skill runs automatically.
5. Validate install replay, cold/fresh task behavior, at least a representative build/check/test per selected repository and service readiness where relevant. Reuse existing scripts; report exact commands, exit results and skipped/blocked checks. Record environment OS, CPU/RAM/disk and actual tool versions, not assumed plan limits. No production smoke test during setup.
6. Review configuration, script/skill contents, repository scope, network, secrets and private visibility; save and let the Owner Publish. Start a fresh task to confirm published state and report discrepancies; a setup-session pass alone is not proof. If a required check cannot run, disclose it and obtain Owner decision before treating the environment as ready.
7. Update via Edit, retest and Republish; verify in a new task. Existing task state is separate. Preserve important work through Git branches/PRs, not VM persistence. Record sanitized configuration and Manifest SHA, repository versions, tool versions, known limitations and manual steps; store reviewed scripts as public assets only if sanitized and portable.

## Security and delivery

- Private environment by default; use package-manager domains plus explicitly justified destinations. Full internet access, new credentials, external side effects and elevated privileges require separate Owner approval. Do not bypass workspace network rules.
- No production credentials, private SSH keys, real customer/mail data, live proxy node configurations or production databases. Use fixtures, mocks, isolated test bindings. If a test credential is essential, obtain explicit approval and use least scope, domain and lifetime. Prefer HTTP secrets for compatible HTTPS requests; direct variables are readable by programs and require care. Never echo values, persist them in images or commit them. Do not put secret-bearing files or logs in Manifest.
- Use platform repository access; do not add broad personal access tokens or grant extra repositories. Inspect untrusted scripts and dependencies. Never execute destructive operations on external systems.
- Cloud is DEV, not PRE/PRO by default. Keep required platform-specific tests on authorized VPS, CI or local devices. Do not downgrade or falsely pass gates when capabilities are missing.
- One task, one scoped branch/PR; verify target SHA, preserve unrelated changes, obey project-local instructions and review gates. Setup alone authorizes no repository changes, release, merge, real messaging or deployment.
- Cross-host handoff records objective, branch/head SHA, checks, blockers and next action in a private or sanitized PR/issue as appropriate. Never place private operational details in public assets.

## Acceptance report

Report profile, selected repositories and SHAs, Manifest SHA, environment resource observations, installed versions, install script/start skill, per-repository verification commands and results, dependency refresh strategy, network allowlist rationale (no secrets), manual actions, unsupported checks, and readiness status (setup validated / blocked / published and fresh-task verified). No claim of publish or live validation without evidence.

Official product reference: [Cloud environments](https://learn.chatgpt.com/docs/environments/cloud-environments). Product capabilities and quotas may change; verify current UI/docs rather than encoding account limits here.
