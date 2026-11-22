# AGENTS.md

## Patterns

- Use `graphical-session.target` for things that should start under any
  compositor; use the compositor-specific target when something only makes
  sense under that one; keep native exec/startup blocks for things that need
  compositor-context ordering or aren't suited to being long-running
  services.
- When unsure how den intends something to be done, check
  [vic/vix](https://github.com/vic/vix) — den author's own personal config,
  and the most mature real-world example of the framework.

## Tooling

- Formatting is done via `nix fmt` (see `modules/formatter.nix`).
