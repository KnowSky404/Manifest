# Restore Flow

Use this order after a reinstall to reduce lockout risk and missing dependencies.

1. Confirm access to password manager, email, MFA, and cloud storage.
2. Restore critical data listed in `data-manifest/`.
3. Install package managers and baseline tooling from `restore/`.
4. Restore configs from `dotfiles/`.
5. Recreate sensitive files from `secrets-template/` using secure backups.
6. Validate the environment with future checks in `scripts/validate/`.
