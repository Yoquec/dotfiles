{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.wayland) waybar;

  volumestatus = pkgs.writeShellScriptBin "volumestatus" (
    builtins.readFile ./waybar/volumestatus.sh
  );
  batterystatus = pkgs.writeShellScriptBin "batterystatus" (
    builtins.readFile ./waybar/batterystatus.sh
  );

  settings = {
    layer = "top";
    position = "bottom";
    height = 28;
    spacing = 10;

    modules-left = [ "hyprland/workspaces" ];
    modules-center = [ ];
    modules-right = [
      "custom/volume"
      "hyprland/language"
      "custom/battery"
      "clock"
      "tray"
    ];

    "hyprland/workspaces" = {
      all-outputs = true;
      disable-scroll = false;
      format = "{name}";
    };

    "hyprland/language" = {
      format = "󰌌 {short}";
    };

    "custom/volume" = {
      exec = lib.getExe volumestatus;
      interval = 1;
      format = "{}";
      tooltip = false;
    };

    "custom/battery" = {
      exec = lib.getExe batterystatus;
      interval = 5;
      format = "{}";
      tooltip = false;
    };

    clock = {
      format = "{:%a %b %d  %H:%M}";
      interval = 10;
      tooltip = false;
    };

    tray = {
      spacing = 8;
    };
  };
in
{
  options.modules.wayland.waybar = {
    enable = lib.mkEnableOption "Enable waybar status bar";
  };

  config = lib.mkIf waybar.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [ settings ];
    };
  };
}
