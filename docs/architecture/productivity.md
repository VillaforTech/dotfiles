# Productivity application ownership

The v1 stack keeps native, low-friction owners instead of adding another
launcher, task database, browser layer, or keyboard remapper.

- Spotlight launches applications.
- Rectangle owns window positioning. `scripts/configure-rectangle` applies the
  seven bindings in `docs/KEYBINDINGS.md`; first-launch Accessibility and login
  item approval remain explicit macOS UI steps.
- Karabiner is absent from the target. Its user services/config are retired;
  any root package remainder must be removed through the supported interactive
  uninstaller.
- GitHub Issues owns engineering backlog; Apple Reminders owns personal next
  actions; the connected calendar owns commitments.
- Chrome is the primary development/session browser and Safari the system and
  personal fallback. Extra browsers leave only after browser-native bookmark,
  profile, and extension exports pass.
- Outlook may remain a calendar/email UI, but automation must name the calendar
  connector it can actually read. The current connector-backed loop uses Google
  Calendar; do not imply Outlook coverage until it is validated.

This file documents ownership, not account details or application data.
