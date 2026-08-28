# Agent autonomy workflow

Routine, reversible work inside the selected workspace proceeds without repeat
confirmation: inspect, edit, install project dependencies, test, format, build,
manage worktrees, commit, and perform task-requested feature pushes or pull
requests. The normal Codex base uses no approval prompts, workspace-scoped
writes, and network access.

Use `cxr` for a deliberately read-only audit. Use `work <alias> --operator`
only when intentional machine or cross-root work needs broader access.

Stop at the smallest meaningful checkpoint before:

- deleting unique or unbacked data;
- force-pushing or rewriting history;
- rotating or revoking credentials before a replacement passes;
- changing sharing, permissions, billing, or public deployment;
- sending an unrequested external message; or
- resolving an ambiguous destructive target.

Public repositories must run their staged credential guard and scan every
outgoing commit, not only the checked-out tree.
