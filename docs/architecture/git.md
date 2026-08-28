# Git architecture

The tracked XDG Git configuration defines workflow defaults while the private
`~/.gitconfig` continues to own identity and credential helpers. Git reads both.

Defaults are:

- new repositories start on `main`;
- pulls are fast-forward-only;
- fetch prunes deleted remote references;
- first push establishes the upstream;
- histogram diffs, moved-line color, and `zdiff3` conflicts improve review;
- rerere remembers and reuses resolved conflicts.

These settings do not switch, rebase, reset, commit, or push an existing
repository on shell startup. Delta is the configured pager and interactive diff
filter; commit signing remains unset until its key and portability decision is
explicit.
