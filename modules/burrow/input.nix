# GTK4's default input context can swallow XKB dead keys (e.g. eu layout
# accents) under Wayland; forcing the simple/compose context fixes it.
# See: https://github.com/ghostty-org/ghostty/discussions/8899
{ ... }:
{
  burrow.input.homeManager = {
    home.sessionVariables.GTK_IM_MODULE = "simple";
  };
}
