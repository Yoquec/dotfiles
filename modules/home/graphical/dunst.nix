{
  lib,
  config,
  ...
}:
let
  inherit (config) xdg;
  inherit (config.modules.graphical) dunst;
in
{
  options.modules.graphical.dunst = {
    enable = lib.mkEnableOption "Enable dunst notifications manager";
  };

  config = lib.mkIf dunst.enable {
    home.file = {
      "${xdg.configHome}/dunst".source = ../../../dotfiles/dunst;
    };
    services.dunst = {
      # TODO: enable on NixOS
      enable = false;
    };
  };
}
