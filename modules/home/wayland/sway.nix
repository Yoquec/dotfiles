{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.wayland) sway;

  mod = "Mod4";

  wallpaper = ../../../assets/wallpapers/charcoal_creation_of_adam.png;

  workspaceBinds = builtins.listToAttrs (
    builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = toString (i + 1);
          key = if i == 9 then "0" else ws;
        in
        [
          {
            name = "${mod}+${key}";
            value = "workspace number ${ws}";
          }
          {
            name = "${mod}+Shift+${key}";
            value = "move container to workspace number ${ws}";
          }
        ]
      ) 10
    )
  );

  keybindings = workspaceBinds // {
    # Focus movement: vim-style hjkl.
    "${mod}+h" = "focus left";
    "${mod}+j" = "focus down";
    "${mod}+k" = "focus up";
    "${mod}+l" = "focus right";

    # Move containers: vim-style hjkl.
    "${mod}+Shift+h" = "move left";
    "${mod}+Shift+j" = "move down";
    "${mod}+Shift+k" = "move up";
    "${mod}+Shift+l" = "move right";

    # Native i3/Sway manual tiling.
    #
    # splitv: side-by-side children (vertical divider).
    # splith: top/bottom children (horizontal divider).
    "${mod}+v" = "splitv";
    "${mod}+Shift+v" = "splith";

    # Native i3/Sway layouts.
    "${mod}+w" = "layout tabbed";
    "${mod}+s" = "layout stacking";
    "${mod}+e" = "layout toggle split";

    # Window actions.
    "${mod}+Shift+space" = "floating toggle";
    "${mod}+Shift+q" = "kill";
    "${mod}+f" = "fullscreen toggle";
    "${mod}+a" = "focus prev";
    "${mod}+r" = "mode resize";

    # Applications and utilities.
    "${mod}+Return" = "exec ghostty";
    "${mod}+d" = "exec rofi -show run";
    "${mod}+b" = "exec rofi -modi emoji -show emoji";
    "${mod}+Shift+d" = "exec rofi -show drun";
    "${mod}+Shift+s" = ''exec grim -g "$(slurp)" - | wl-copy'';
    "${mod}+Ctrl+l" = "exec swaylock";
    "${mod}+p" = "exec pass-choose";
    "${mod}+o" = "exec otp-choose";

    # Sway lifecycle.
    "${mod}+Shift+r" = "reload";
    "${mod}+Shift+e" = "exec swaymsg exit";

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

    # Mouse: Mod + left-drag moves, Mod + right-drag resizes.
    "${mod}+button1" = "move position mouse";
    "${mod}+button3" = "resize set width 50 ppt height 50 ppt";
  };

  resizeMode = {
    h = "resize shrink width 10 px";
    j = "resize grow height 10 px";
    k = "resize shrink height 10 px";
    l = "resize grow width 10 px";

    Left = "resize shrink width 10 px";
    Down = "resize grow height 10 px";
    Up = "resize shrink height 10 px";
    Right = "resize grow width 10 px";

    Return = "mode default";
    Escape = "mode default";
    "${mod}+r" = "mode default";
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

      # Retain this only if Sway is supplied by your NixOS config.
      # Otherwise remove it and let Home Manager install pkgs.sway.
      package = null;

      xwayland = true;
      systemd.enable = true;

      config = {
        modifier = mod;

        terminal = "ghostty";
        menu = "rofi -show drun";

        # Do not start Sway's built-in swaybar: Waybar is external.
        bars = [ ];

        # Hyprland: border_size = 5; rounding = 0.
        window = {
          border = 5;
          titlebar = false;
        };

        # Equivalent of gaps_in / gaps_out.
        gaps = {
          inner = 5;
          outer = 5;
        };

        # Hyprland follow_mouse = 1.
        focus = {
          followMouse = true;
          newWindow = "smart";
          wrapping = "no";
        };

        # Similar to your preferred manual tiling baseline.
        workspaceLayout = "default";

        # Sway's built-in Mod-drag behavior.
        floating = {
          modifier = mod;
          criteria = [
            { class = "R_x11"; }
            { class = "Thunar"; }
            { class = "Lxappearance"; }
            { class = "gnome-calculator"; }

            # Native Wayland equivalents, matched by app_id.
            { app_id = "thunar"; }
            { app_id = "lxappearance"; }
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

        # Equivalent to ",preferred,auto,1.33".
        output."*" = {
          scale = "1.33";
        };

        keybindings = keybindings;
        modes.resize = resizeMode;

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
          {
            command = "${lib.getExe pkgs.swaybg} -i ${wallpaper} -m fill";
            always = false;
          }
        ];
      };

      extraConfig = ''
        # Ensure a 5px border with no titlebar.
        default_border pixel 5
        default_floating_border pixel 5

        # Make Waybar own the top layer rather than Sway's native bar.
        # Its systemd service should be enabled by your Waybar module.

        # Keep a fixed non-animated presentation. Sway itself does not
        # implement Hyprland-style animation settings.

        # These cover cases where GTK applications expose a Wayland app_id
        # rather than an XWayland class.
        for_window [app_id="thunar"] floating enable
        for_window [app_id="org.gnome.Calculator"] floating enable
      '';
    };
  };
}
