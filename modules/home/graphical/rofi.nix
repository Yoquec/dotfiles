{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config) xdg;
  inherit (config.modules.graphical) rofi;
in
{
  options.modules.graphical.rofi = {
    enable = lib.mkEnableOption "Enable rofi picker";
  };

  config = lib.mkIf rofi.enable {
    home.file = {
      "${xdg.configHome}/rofi".source = ../../../dotfiles/rofi;
    };
    programs.rofi = {
      enable = false;
      pass.enable = true;
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    };
  };
}
