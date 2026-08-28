# Automation architecture

Automation should remove routine coordination without creating a second source
of truth.

- GitHub Issues owns engineering backlog; Apple Reminders owns personal next
  actions; the connected calendar owns commitments.
- Connector reads may produce derived briefs, links, and decisions. Raw mail,
  calendar payloads, credentials, and private account inventories do not enter
  Git.
- A recurring personal brief may update the private knowledge repository with
  conflict-stop, fast-forward-only Git behavior. It must not force, reset,
  publish, send messages, or delete source data.
- Repository health and burn-in monitors should notify on changes, decisions,
  or failures instead of generating repetitive noise.
- macOS permission grants, credential rotation, and application extension
  installation remain explicit interactive checkpoints.

Only one synchronization engine may own a working copy. GitHub access through
clean clones is distinct from native mobile editing; choose a mobile Git client
or Obsidian Sync deliberately, and never layer both onto the same vault without
a tested topology.
