{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.wayland) sway;
  modifier = "Mod4";

  cfg = config.wayland.windowManager.sway.config;

  keybindings = {
    # Default keybinds
    # See: https://github.com/nix-community/home-manager/blob/master/modules/services/window-managers/i3-sway/sway.nix#L78
    "${modifier}+Shift+q" = "kill";
    "${modifier}+d" = "exec ${cfg.menu}";
    "${modifier}+Return" = "exec ${cfg.terminal}"; # terminal should be set by its module

    "${modifier}+${cfg.left}" = "focus left";
    "${modifier}+${cfg.down}" = "focus down";
    "${modifier}+${cfg.up}" = "focus up";
    "${modifier}+${cfg.right}" = "focus right";

    "${modifier}+Left" = "focus left";
    "${modifier}+Down" = "focus down";
    "${modifier}+Up" = "focus up";
    "${modifier}+Right" = "focus right";

    "${modifier}+Shift+${cfg.left}" = "move left";
    "${modifier}+Shift+${cfg.down}" = "move down";
    "${modifier}+Shift+${cfg.up}" = "move up";
    "${modifier}+Shift+${cfg.right}" = "move right";

    "${modifier}+Shift+Left" = "move left";
    "${modifier}+Shift+Down" = "move down";
    "${modifier}+Shift+Up" = "move up";
    "${modifier}+Shift+Right" = "move right";

    "${modifier}+b" = "splith";
    "${modifier}+v" = "splitv";
    "${modifier}+f" = "fullscreen toggle";
    "${modifier}+a" = "focus parent";

    "${modifier}+s" = "layout stacking";
    "${modifier}+w" = "layout tabbed";
    "${modifier}+e" = "layout toggle split";

    "${modifier}+Shift+space" = "floating toggle";
    "${modifier}+space" = "focus mode_toggle";

    "${modifier}+1" = "workspace number 1";
    "${modifier}+2" = "workspace number 2";
    "${modifier}+3" = "workspace number 3";
    "${modifier}+4" = "workspace number 4";
    "${modifier}+5" = "workspace number 5";
    "${modifier}+6" = "workspace number 6";
    "${modifier}+7" = "workspace number 7";
    "${modifier}+8" = "workspace number 8";
    "${modifier}+9" = "workspace number 9";
    "${modifier}+0" = "workspace number 10";

    "${modifier}+Shift+1" = "move container to workspace number 1";
    "${modifier}+Shift+2" = "move container to workspace number 2";
    "${modifier}+Shift+3" = "move container to workspace number 3";
    "${modifier}+Shift+4" = "move container to workspace number 4";
    "${modifier}+Shift+5" = "move container to workspace number 5";
    "${modifier}+Shift+6" = "move container to workspace number 6";
    "${modifier}+Shift+7" = "move container to workspace number 7";
    "${modifier}+Shift+8" = "move container to workspace number 8";
    "${modifier}+Shift+9" = "move container to workspace number 9";
    "${modifier}+Shift+0" = "move container to workspace number 10";

    "${modifier}+Shift+minus" = "move scratchpad";
    "${modifier}+minus" = "scratchpad show";

    "${modifier}+Shift+c" = "reload";
    "${modifier}+Shift+e" =
      "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

    "${modifier}+r" = "mode resize";

    # Media keys.
    "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
    "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
    "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
    "XF86AudioPrev" = "exec playerctl previous";
    "XF86AudioPlay" = "exec playerctl play-pause";
    "XF86AudioPause" = "exec playerctl play-pause";
    "XF86AudioStop" = "exec playerctl stop";
    "XF86AudioNext" = "exec playerctl next";
    "XF86MonBrightnessDown" = "exec light -s sysfs/backlight/amdgpu_bl1 -U 5";
    "XF86MonBrightnessUp" = "exec light -s sysfs/backlight/amdgpu_bl1 -A 5";
    "XF86AudioMedia" = "exec mate-calc";

    "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | pbcopy";
    "${modifier}+Ctrl+l" = "exec swaylock";

    # Mouse: Mod + left-drag moves, Mod + right-drag resizes.
    "${modifier}+button1" = "move position mouse";
    "${modifier}+button3" = "resize set width 50 ppt height 50 ppt";
  };
in
{
  imports = [
    ./waybar
  ];

  options.modules.wayland.sway = {
    enable = lib.mkEnableOption "Enable Sway via home-manager";
  };

  config = lib.mkIf sway.enable {
    modules.graphical.rofi.enable = lib.mkForce true;
    modules.graphical.dunst.enable = lib.mkForce true;
    modules.graphical.ghostty.enable = lib.mkForce true;
    programs.swaylock.enable = true;

    home.packages = with pkgs; [
      wl-clipboard-rs
      grim
      slurp
      swayidle
      swaybg
    ];

    programs.zsh.shellAliases = {
      pbcopy = "wl-copy";
      pbpaste = "wl-paste";
    };

    services.wlsunset = {
      enable = true;
      latitude = 40.41;
      longitude = 3.69;

      temperature = {
        day = 3600;
        night = 2000;
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      xwayland = true;
      systemd.enable = true;

      config = {
        inherit modifier keybindings;
        workspaceLayout = "default";
        defaultWorkspace = "workspace number 1";

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
          {
            command = "swayidle";
            always = false;
          }
          {
            command = "nm-applet --indicator";
            always = false;
          }
          {
            command = "blueberry-tray";
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
