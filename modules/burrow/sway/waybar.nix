# https://github.com/Alexays/Waybar
{ ... }:
{
  burrow.sway.homeManager =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      volumestatus = pkgs.writeShellApplication {
        name = "volumestatus";
        runtimeInputs = [ pkgs.pulseaudio ];
        text = builtins.readFile ./bin/volumestatus;
      };

      batterystatus = pkgs.writeShellApplication {
        name = "batterystatus";
        runtimeInputs = [ pkgs.upower ];
        text = builtins.readFile ./bin/batterystatus;
      };

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
          "custom/volume"
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
      programs.waybar = {
        enable = true;
        settings = [ settings ];
      };

      wayland.windowManager.sway.config = {
        startup = [
          {
            command = "${lib.getExe config.programs.waybar.package}";
            always = false;
          }
        ];
        # Disable swaybar's native bar
        bars = lib.mkForce [ ];
      };
    };
}
