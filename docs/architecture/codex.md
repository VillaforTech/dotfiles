# Codex autonomy

The live `~/.codex/config.toml` is machine-private. It owns exact trusted paths,
plugin and connector state, and machine-specific MCP definitions, so the
dotfiles repository intentionally does not symlink or publish it.

`codex/config.example.toml` documents the portable productivity-first user
base: no approval prompts, workspace-scoped writes, and network access.
`codex/project.config.toml` records the same autonomy policy inside an exact
user-owned repository. A project may narrow or specialize the base, but it
cannot grant itself broader machine access merely by containing a project
config.

`codex/AGENTS.md` is the sanitized global working agreement. The live copy may
be refreshed from it after reviewing local policy changes. Repository-specific
commands and invariants belong in the nearest project `AGENTS.md`.

Normal project work uses `approval_policy = "never"`, workspace-scoped writes,
and network access. The `cxr` shell alias remains the explicit read-only audit
mode. `work <alias> --operator` is the intentional cross-root escape hatch and
starts Codex with `danger-full-access` plus `on-request`; it is not a default
shell mode.

Do not add connector credentials, secrets, machine paths, trust entries, or the
live config to this repository.

Native g-stack is optional. The current evaluation keeps only a focused router
and a small set of planning, investigation, review, QA, context, health, and
developer-experience routes registered globally. The pinned checkout and
disabled-registration manifest make that trim reversible. Permanent adoption
requires evidence from real tasks; setup success alone is not an adoption
decision.
