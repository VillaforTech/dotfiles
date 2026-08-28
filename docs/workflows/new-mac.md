# New Mac workflow

1. Install Xcode Command Line Tools and Homebrew.
2. Clone this repository to `~/.config/dotfiles`, set
   `core.hooksPath=.githooks`, and run `scripts/link-config --dry-run`.
3. Apply links. Use `--backup-existing` only after reviewing exact conflicts.
4. Install the curated Homebrew state with `brew bundle`.
5. Run `scripts/configure-rectangle` while Rectangle is quit, then launch it to
   grant Accessibility and confirm its login item.
6. Recreate the shared Jupyter tool with `scripts/install-jupyter-tool`.
7. Create the private mode-`0600` project registry from
   `work/projects.example.toml`.
8. Restore development secrets to login Keychain services named
   `dev.env.<VARIABLE>`; never copy plaintext shell exports.
9. Restore the private knowledge repository as a clean clone, then validate its
   own bootstrap and guard before opening it in Obsidian.
10. Run `tests/run`, `git diff --check`, and a clean login-shell test.

Application profiles, connector authentication, Zotero data, Obsidian vault
content, live Codex state, and the populated work registry are private restore
inputs, not dotfiles.
