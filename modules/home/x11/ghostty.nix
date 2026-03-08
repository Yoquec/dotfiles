{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config) theme;
  inherit (config.modules.x11) ghostty;
  inherit (config.modules.development) zsh;

  isLinux = lib.hasInfix "linux" pkgs.stdenv.hostPlatform.system;

  settings = {
    theme = if theme == "dark" then "Tomorrow Night Bright" else "Tomorrow";
    palette = [
      "0=#404040"
    ];

    font-size = 14;
    font-family = "monospace";
    font-style = "Medium";
    font-style-bold = "Bold";
    font-style-italic = "Medium Italic";
    font-style-bold-italic = "Bold Italic";

    cursor-style = "block";
    cursor-style-blink = false;
    cursor-color = "#cb82ed";

    window-padding-x = "20";
    window-padding-y = "25, 5";
  }
  // (
    if isLinux then
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
  options.modules.x11.ghostty = {
    enable = lib.mkEnableOption "Enable ghostty";
  };

  config.programs.ghostty = {
    inherit (ghostty) enable;
    inherit settings;
    enableZshIntegration = zsh.enable;
  };
}
