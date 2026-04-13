# Conventions

## Naming

- Use `shared/`, `unix/`, and `windows/` for platform scope.
- Use one directory per tool instead of scattering files at the same level.
- Use `*.example` or `*.template` for files that should never contain live secrets.

## File Rules

- Each tool directory should include a short `README.md` explaining the real path, target shell or app, and any prerequisites.
- Sensitive values stay outside the repository. This repo stores structure, expectations, and recovery instructions only.
- When platform behavior diverges, prefer a shared base plus a small platform-specific file instead of duplicating everything.

## Suggested Workflow

1. Recover accounts and critical data first.
2. Install base packages and core tooling.
3. Restore shared configs.
4. Apply platform-specific configs.
5. Rehydrate secrets from secure external storage.
