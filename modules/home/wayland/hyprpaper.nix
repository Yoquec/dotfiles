{ lib, config, ... }:
let
  inherit (config.modules.wayland) hyprpaper;

  wallpaper = ../../../assets/wallpapers/charcoal_creation_of_adam.png;
in
{
  options.modules.wayland.hyprpaper = {
    enable = lib.mkEnableOption "Enable hyprpaper wallpaper daemon";
  };

  config = lib.mkIf hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ "${wallpaper}" ];
        wallpaper = [ ",${wallpaper}" ];
      };
    };
  };
}
