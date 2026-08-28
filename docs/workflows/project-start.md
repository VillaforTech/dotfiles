# Project start workflow

`work <alias>` reads the exact root from the private mode-`0600` registry at
`~/.config/work/projects.toml`, shows the branch and dirty state, optionally
performs a configured clean-tree fast-forward-only sync, and creates this named
tmux layout once:

```text
code:  Neovim | Codex
run:   runtime | logs
shell: ordinary project shell
```

Subsequent calls attach to the existing session without recreating windows.
`--no-sync` skips metadata and fast-forward work. `--operator` changes only the
Codex pane to the explicit machine-operator flags. The helper never resets,
forces, deletes work, switches branches, kills another session, or executes the
reserved `startup` field.

Copy `work/projects.example.toml` to the private registry and register only
exact, intentional roots. Do not track the populated registry.
