# Repository Overview

`Manifest` is organized around recovery assets rather than operating systems.

## Principles

- Keep configuration files separate from restore procedures.
- Store templates and notes for sensitive assets, not real secrets.
- Prefer shared tool configs first, then platform-specific overlays.
- Keep machine-specific differences out of the common path until they are needed.

## Top-Level Layout

- `dotfiles/`: configuration files and templates
- `restore/`: system rebuild checklists and ordered recovery notes
- `apps/`: software inventory by category
- `data-manifest/`: high-value data and export/import notes
- `secrets-template/`: sanitized examples and required secret inventory
- `scripts/`: future bootstrap and validation helpers
