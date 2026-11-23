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
- If an aspect's config depends on something another aspect provides (e.g.
  `config.lib.stylix.*`/`config.yoq.theme.*` from `yoq.theme`, a `pkgs`
  overlay from `burrow.graphics`), declare that aspect in its own `includes`
  instead of relying on it arriving transitively through some other included
  aspect.

## Agent environment

- `nix` is not available in agent sandboxes. Nothing written here gets
  evaluated, built, or `nix fmt`-checked before landing -- say so explicitly
  rather than implying a change was verified.

## Tooling

- Formatting is done via `nix fmt` (see `modules/formatter.nix`).
