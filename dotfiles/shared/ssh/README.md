# SSH Config

- Scope: cross-platform where OpenSSH is available
- Real target: `~/.ssh/config`
- Repository policy: store sanitized config only

Do not commit private keys, hostnames that should stay private, or live usernames if they reveal sensitive infrastructure.
