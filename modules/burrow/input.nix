# GTK4's default input context can swallow XKB dead keys (e.g. eu layout
# accents) under Wayland; forcing the simple/compose context fixes it.
# See: https://github.com/ghostty-org/ghostty/discussions/8899
#
# Set at the NixOS level (pam_env), not home.sessionVariables: greetd
# execs sway directly, so nothing sources hm-session-vars.sh.
{ ... }:
{
  burrow.input.nixos = {
    environment.sessionVariables.GTK_IM_MODULE = "simple";
  };
}
