# Zsh Config

- Scope: macOS, Linux, and WSL
- Real target: `~/.zshrc`
- Keep shell startup small and portable. Move machine-specific logic into sourced local files outside the repo when needed.

Included functions:

- `setProxy [host] [port]`: shared proxy setter
- `unsetProxy`: clear all proxy environment variables
- `setRemoteProxy [host] [port]`: defaults to `127.0.0.1:9929`
- `setLocalProxy [host] [port]`: defaults to `127.0.0.1:7890`
