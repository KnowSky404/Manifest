# Codex Cloud environment variables and secrets

English | [简体中文](CODEX_CLOUD_ENVIRONMENT_VARIABLES.zh-CN.md)

Status: recommended shared configuration · Version: 1.0

Companion to the [environment baseline](CODEX_CLOUD_ENVIRONMENTS.md). These are recommended settings, not native configuration files or a complete inventory of repository requirements. Never paste the entire document into a variable editor. Confirm the current project contracts, workspace restrictions and actual runtime first.

## Configuration scopes

| Scope | Purpose |
| --- | --- |
| Environment variables | Non-sensitive values required by programs across the selected environment |
| Personal vault | Personal values requested by an environment; use All environments only for harmless common preferences, otherwise Selected environments |
| Project-local configuration | Repository-specific ignored .env/.dev.vars or command-scoped variables, generated from the reviewed example |
| HTTP secrets | Approved test-only HTTPS credentials, with narrowly scoped allowed hosts |
| GitHub Actions / authorized release system | Production credentials and release configuration; not imported to Cloud DEV |

Personal values are injected only when requested by the environment. An environment-specific personal value overrides its general personal default. Avoid defining one key in multiple scopes unless a documented override is intended; verify application-specific dotenv precedence rather than assuming it. Do not use the same key for a direct variable and an HTTP secret.

## Common values for all four environments

Suggested direct variables (or requested Personal vault values). Preserve platform-managed settings. Explicit project/test requirements take precedence.

| Key | Suggested value | Condition |
| --- | --- | --- |
| TZ | Asia/Shanghai | Preferred interactive/log timezone; override for UTC or timezone-sensitive tests |
| LANG | C.UTF-8 | Verify locale support; do not force if unavailable |
| EDITOR | vim | Optional; only if installed |
| VISUAL | vim | Optional; only if installed |
| GIT_PAGER | cat | Optional, non-interactive Git output |
| PIP_DISABLE_PIP_VERSION_CHECK | 1 | Optional when pip is used |
| NO_UPDATE_NOTIFIER | 1 | Optional for compatible CLI tools; not a security-update policy |

Minimum recommended UI entries: TZ and LANG if supported. Optional preferences need not be set everywhere. No global CI=true, NODE_ENV, LC_ALL, PATH, CODEX_HOME, HTTP_PROXY, HTTPS_PROXY, ALL_PROXY or NO_PROXY overrides; scope to individual commands only when justified and do not bypass network controls. Do not set OPENAI_API_KEY merely to run Codex.

## Profile-specific settings

### web-dev

| Key | Suggested value | Scope / purpose |
| --- | --- | --- |
| WRANGLER_SEND_METRICS | false | Environment, when using Wrangler |
| PUBLIC_BASE_PATH | / for local dev | today-eat-what only, project-local; use the correct path for a target build |
| TARO_APP_ID | unset initially | today-eat-what only; Owner supplies authorized AppID when required |
| WEAPP_DESC | unset initially | Optional local release note; not needed for ordinary development |
| PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD | unset | Follow project browser setup; do not suppress required browser installation |

PureTools, WebTweaks and singdeck: no extra mandatory Cloud UI values identified in the sampled configuration; inspect actual code before declaring complete. Keep endpoint fixtures local and synthetic. Do not import WEAPP_PRIVATE_KEY_PATH or its signing/upload key into shared web-dev; preview/upload requiring real authorization remains external.

### flaremail-dev

Set WRANGLER_SEND_METRICS=false at environment scope if Wrangler is used. Prefer a Git-ignored, task-local .dev.vars derived from FlareMail's [.dev.vars.example](https://github.com/KnowSky404/FlareMail/blob/main/.dev.vars.example), not a second global copy in Cloud UI. Inspect current runtime config and local auth bootstrap first; no real account or remote bindings.

| Key | Sample local value | Purpose |
| --- | --- | --- |
| APP_ENV | development | DEV |
| ALLOW_FAKE_SERVICES | true | Local fake services |
| OUTBOUND_PROVIDER | demo | Simulated outbound only |
| AUTH_MODE | local | Local authentication |
| TELEGRAM_ENABLED | false | No live bot |
| AUTO_REPLY_ENABLED | true | Repository example; only with fake outbound |
| INBOUND_NOTIFICATION_ENABLED | true | Repository example; only with isolated fake delivery |
| APP_BASE_URL | http://127.0.0.1:8787 | Adjust to actual local service/port |

These are sample values from the repository, not an exhaustive contract. Verify that no real email, notification, external API or production storage is reachable through these settings. Disable auto-replies and notifications if fake delivery cannot be established. Use temporary local data and synthetic identities; run local migrations/bootstrap only when authorized. Protect ignored credential files with mode 0600 where supported. Never bake a real credential or private mailbox into the published filesystem.

### network-dev

| Key | Suggested value | Scope / purpose |
| --- | --- | --- |
| WRANGLER_SEND_METRICS | false | Environment if SubMan or other Wrangler projects are selected |
| GOTOOLCHAIN | project/default | Do not override globally; follow go.mod and CI |
| GOPROXY | default | Do not hardcode a mirror without need |
| SINGBOX_BINARY_114 | actual validated binary path | sing-box-vps scoped test variable, if current test contract requires it |
| SINGBOX_BINARY_113 | actual validated binary path or unset | Optional compatibility testing only if current test contract requires it |

Resolve binary paths and versions from the current repository tests and CI, not from assumed host paths. Version-suffixed keys are observed examples, not permanent API guarantees. No live proxy subscriptions, node credentials, SSH private keys or production Cloudflare bindings. Real privileged networking remains on an authorized test host.

### general-dev

Use only the common values, as applicable. No mandatory project-specific Cloud UI variables. Use temporary HOME/XDG paths per test when validating dotfiles; never globally replace Cloud-managed HOME or alter real host configuration. HTTP secrets initially empty.

## Secrets and network policy

Start every profile with zero HTTP secrets. Only add a credential for a documented, separately authorized test requirement; a credential's ability to call an API is not authorization to perform actions.

| Candidate key | Allowed host | Scope / purpose |
| --- | --- | --- |
| CLOUDFLARE_EMAIL_ROUTING_READ_TOKEN | api.cloudflare.com | flaremail-dev; read-only test zone routing |
| RESEND_API_KEY | api.resend.com | flaremail-dev; isolated test account/domain, only with approval for actual sending |
| CLOUDFLARE_API_TOKEN | api.cloudflare.com | Dedicated test resources only; never production/deploy token |
| OPENAI_API_KEY | api.openai.com | Optional application API test, not Codex authentication |
| DEEPSEEK_API_KEY | api.deepseek.com | Optional application API test |
| GH_TOKEN or GITHUB_TOKEN | api.github.com | Only if platform repository access is insufficient and explicitly approved; prefer scoped authorization |

Names are examples of candidate credentials, not a requirement or proof that any client supports HTTP-secret substitution. Confirm actual client key, destination and compatibility. No broad PAT, live Telegram token, webhook/HMAC signing secret or private key in public files. For secrets required in raw form for local signing/cryptography, HTTP substitution is not suitable; prefer mock credentials, otherwise obtain separate authorization and use a tightly scoped direct secret without persisting it. Never print secret values, run full env dumps, include them in logs, screenshots, PRs, images or prepared filesystem snapshots.

For HTTP secrets the program gets a placeholder and compatible HTTPS requests on port 443 are mediated by the proxy. Use distinct keys from direct variables. Environment-owned HTTP secrets also add their allowed domains; Personal vault values and direct variables do not. Recheck the effective network policy. Default: full public internet off, package manager domains on where needed, explicit extra hosts only, private visibility, no VPN/OIDC unless separately justified.

## Setup / update checklist

1. Inspect each selected repository's AGENTS.md, example env files, Wrangler/runtime config, package scripts, CI and actual environment reads; classify every required/optional key and its consumer. Do not assume this list is exhaustive.
2. Compare common recommendations against existing environment settings; preserve intentional Owner values and project-required behavior. Apply safe supported settings through the UI/setup if available, otherwise give exact Key/Value and manual steps. Avoid duplicate definitions or unknown keys.
3. Generate ignored local config from reviewed templates; validate precedence, local-only bindings, dummy credentials and behavior without optional secrets. Do not modify business repositories as a side effect.
4. Report key, non-sensitive example/default (or unset), scope, required/optional, consumer, status, allowed host and minimum privilege if applicable. For secrets report presence/absence only, never values. Identify remaining owner actions and unverified paths.
5. Test representative commands with the effective configuration, prove fake-only external effects where required, review prepared files, then let Owner publish/republish and verify a fresh task. Missing required credentials or tests are blockers, not passes.

References: [official Cloud environment configuration](https://learn.chatgpt.com/docs/environments/cloud-environments), [today-eat-what example](https://github.com/KnowSky404/today-eat-what/blob/main/.env.example), [sing-box-vps CI contract](https://github.com/KnowSky404/sing-box-vps/blob/main/.github/workflows/command-contract.yml), [SubMan deployment workflow](https://github.com/KnowSky404/SubMan/blob/main/.github/workflows/deploy.yml). Project examples were sampled, not exhaustively audited; recheck current reviewed revisions at setup.
