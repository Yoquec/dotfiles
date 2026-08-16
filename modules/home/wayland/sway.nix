{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.wayland) sway;
  modifier = "Mod4";

  keybindings = {
    # Media keys.
    "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
    "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
    "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
    "XF86AudioPrev" = "exec playerctl previous";
    "XF86AudioPlay" = "exec playerctl play-pause";
    "XF86AudioNext" = "exec playerctl next";
    "XF86MonBrightnessDown" = "exec light -s sysfs/backlight/amdgpu_bl1 -U 5";
    "XF86MonBrightnessUp" = "exec light -s sysfs/backlight/amdgpu_bl1 -A 5";
    "XF86AudioMedia" = "exec mate-calc";

    # Screenshots
    "${modifier}+Shift+s" = "exec grim";

    # Mouse: Mod + left-drag moves, Mod + right-drag resizes.
    "${modifier}+button1" = "move position mouse";
    "${modifier}+button3" = "resize set width 50 ppt height 50 ppt";
  };
in
{
  options.modules.wayland.sway = {
    enable = lib.mkEnableOption "Enable Sway via home-manager";
  };

  config = lib.mkIf sway.enable {
    modules.wayland.waybar.enable = lib.mkForce true;
    modules.graphical.rofi.enable = lib.mkForce true;
    modules.graphical.dunst.enable = lib.mkForce true;
    modules.graphical.ghostty.enable = lib.mkForce true;
    services.ssh-agent.enable = true;

    home.packages = with pkgs; [
      wl-clipboard-rs
      grim
      slurp
      swayidle
      swaylock
      swaybg
    ];

    programs.zsh.shellAliases = {
      pbcopy = "wl-copy";
      pbpaste = "wl-paste";
    };

    wayland.windowManager.sway = {
      enable = true;

      # Package managed by the system package manager
      # TODO: remove this when moving to NixOS
      package = null;

      xwayland = true;
      systemd.enable = true;

      config = {
        inherit modifier;
        workspaceLayout = "default";
        defaultWorkspace = "workspace number 1";

        # HACK: Extend default keybindings
        keybindings = lib.mkOptionDefault keybindings;

        output."eDP-1" = {
          scale = "1.33";
        };

        window = {
          border = 5;
          titlebar = false;
        };

        floating = {
          border = 5;
          titlebar = false;
        };

        gaps = {
          inner = 5;
          outer = 5;
          smartBorders = "on";
        };

        focus = {
          followMouse = true;
          newWindow = "smart";
          wrapping = "no";
        };

        floating = {
          modifier = modifier;
          criteria = [
            { app_id = "org.gnome.Calculator"; }
          ];
        };

        input."*" = {
          xkb_layout = "eu";
          xkb_options = "caps:swapescape";
          repeat_delay = "300";
          repeat_rate = "50";
        };

        input."type:touchpad" = {
          natural_scroll = "enabled";
        };

        startup = [
          # Replace hypridle with Sway's native idle daemon.
          {
            command = "swayidle";
            always = false;
          }

          # Start/restart Waybar only if you manage it as a systemd user service.
          {
            command = "systemctl --user restart waybar";
            always = true;
          }

          {
            command = "nm-applet";
            always = false;
          }
          {
            command = "easyeffects --hide-window --load-preset fw13-easy-effects";
            always = false;
          }
          {
            command = "blueberry-tray";
            always = false;
          }
          {
            command = "hyprsunset";
            always = false;
          }
          {
            command = "nextcloud";
            always = false;
          }
        ];
      };
    };
  };
}
