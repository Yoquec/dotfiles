{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.graphical) ghostty;
  inherit (config.modules.development) zsh;
  inherit (config.lib.stylix) colors;

  settings = {
    font-family = "monospace";
    font-style = "Medium";
    font-style-bold = "Bold";
    font-style-italic = "Medium Italic";
    font-style-bold-italic = "Bold Italic";

    cursor-style = "block";
    cursor-style-blink = false;
    cursor-color = colors.withHashtag.base0E;

    window-padding-x = "20";
    window-padding-y = "25, 5";
  }
  // (
    if pkgs.stdenv.isLinux then
      {
        window-decoration = "server";
        window-theme = "system";
        gtk-titlebar = false;
        gtk-single-instance = true;
      }
    else
      { }
  );
in
{
  options.modules.graphical.ghostty = {
    enable = lib.mkEnableOption "Enable ghostty";
  };

  config = lib.mkIf ghostty.enable {
    programs.ghostty = {
      inherit settings;
      enable = true;
      enableZshIntegration = zsh.enable;
    };

    wayland.windowManager.sway.config.terminal = "ghostty";
  };
}
