# Shell architecture

Zsh startup has one owner per concern:

- `.zshenv` contains only portable XDG/locale process state.
- `.zprofile` initializes Homebrew and the login PATH once.
- `.zshrc` owns interactive preferences and loads `custom.zsh` and `aliases.zsh`.
- `typeset -U path PATH` keeps PATH stable when an inherited environment already contains repeated entries.

Interactive integrations are conditional on their executables or readable
files. Startup reads the tracked Starship configuration but does not mutate it.
The `fd` executable is never shadowed; `cdf` is the interactive directory
picker. `fh` places a history result on the edit buffer instead of executing it.

Project variables belong in a Git-ignored project file loaded through direnv
after `direnv allow`. Credentials do not belong in tracked configuration or a
global shell environment.

Long-lived development credentials use login Keychain services named
`dev.env.<VARIABLE>`. Load only the variables a subprocess needs:

```bash
with-dev-secrets ANTHROPIC_API_KEY -- ./run-anthropic-task
with-dev-secrets GOOGLE_CLIENT_ID,GOOGLE_CLIENT_SECRET -- ./run-oauth-task
```

The helper first removes the known legacy credential names from its own
environment, retrieves only the requested items, and `exec`s the requested
command. The calling shell never receives the values. Provider-side rotation
is a separate operation; moving a value into Keychain does not revoke an old
credential.
