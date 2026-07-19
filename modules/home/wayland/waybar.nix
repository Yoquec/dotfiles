{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.wayland) waybar;

  # volumestatus = pkgs.writeShellScriptBin "volumestatus" (builtins.readFile ./waybar/volumestatus.sh);
  batterystatus = pkgs.writeShellScriptBin "batterystatus" (
    builtins.readFile ./waybar/batterystatus.sh
  );

  settings = {
    layer = "top";
    position = "bottom";
    height = 28;
    spacing = 10;

    modules-left = [
      "sway/workspaces"
      "sway/mode"
    ];
    modules-center = [ ];
    modules-right = [
      "pulseaudio"
      "sway/language"
      "custom/battery"
      "clock"
      "tray"
    ];

    "sway/workspaces" = {
      disable-scroll = false;
      all-outputs = true;
      current-only = false;
      format = "{name}";
    };

    "sway/language" = {
      format = "󰌌 {short}";
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
