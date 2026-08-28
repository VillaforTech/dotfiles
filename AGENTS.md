# Dotfiles working agreement

- Read `docs/README.md`; executable configuration and `tests/run` are the
  behavior authority.
- Preview links with `scripts/link-config --dry-run`. Applying a replacement to
  an existing regular path requires the script's explicit backup mode.
- Treat `homebrew/Brewfile` as a curated desired-state manifest. Generate any
  whole-machine dump only to a temporary review file.
- Never print, stage, or commit credentials. Long-lived development variables
  belong in login Keychain and are loaded only through `with-dev-secrets`.
- Validate tmux on a private test socket; never kill the user's default server.
- Preserve unrelated local Neovim work, especially `.session.vim`,
  `nvim/lazy-lock.json`, and `nvim/lua/plugins/live-preview.lua`, unless the task
  explicitly includes it.
- Run `./tests/run` and `git diff --check` before proposing a public commit.
