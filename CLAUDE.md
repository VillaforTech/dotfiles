# Claude Code compatibility note

This repository's current operating contract is [AGENTS.md](AGENTS.md). Read
[README.md](README.md) and [docs/README.md](docs/README.md) before changing
configuration.

The historical setup commands formerly stored here are intentionally retired:
they described global secret exports, implicit tmux/session behavior, destructive
symlink resets, and an unisolated tmux validation command that no longer match
the executable configuration.

Use only the current entrypoints:

```bash
./scripts/link-config --dry-run
./tests/run
HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check --file=homebrew/Brewfile --no-upgrade
```

Do not replace the curated Brewfile with a whole-machine dump. Do not stage or
print credential values. Do not kill the default tmux server during validation.
