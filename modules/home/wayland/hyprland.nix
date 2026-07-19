{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.wayland) hyprland;

  workspaceBinds = builtins.concatLists (
    builtins.genList (
      i:
      let
        ws = toString (i + 1);
        key = if i == 9 then "0" else toString (i + 1);
      in
      [
        "$mod, ${key}, workspace, ${ws}"
        "$mod SHIFT, ${key}, movetoworkspace, ${ws}"
      ]
    ) 10
  );

  variables = {
    "$mod" = "SUPER";
  };

  look = {
    general = {
      border_size = 5;
      gaps_in = 2;
      gaps_out = 8;
      layout = "dwindle";
      no_focus_fallback = true;
    };
    decoration = {
      rounding = 0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      blur.enabled = false;
      shadow.enabled = false;
    };
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
    };
    animations = {
      enabled = false;
    };
  };

  layout = {
    dwindle = {
      preserve_split = true;
    };
    group = {
      groupbar.enabled = true;
    };
  };

  input = {
    input = {
      kb_layout = "eu";
      kb_options = "caps:swapescape";
      follow_mouse = 1;
      repeat_delay = 300;
      repeat_rate = 50;
    };
  };

  binds = {
    bind = [
      "$mod SHIFT, SPACE, togglefloating"
      "$mod SHIFT, Q, killactive"
      "$mod, F, fullscreen, 0"

      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, J, movewindow, d"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, L, movewindow, r"

      "$mod, V, layoutmsg, togglesplit"
      "$mod SHIFT, V, layoutmsg, togglesplit"
      "$mod, E, layoutmsg, togglesplit"

      "$mod, W, togglegroup"
      "$mod, TAB, changegroupactive, f"
      "$mod SHIFT, TAB, changegroupactive, b"

      "$mod, A, movefocus, prev"

      "$mod, R, submap, resize"

      "$mod, RETURN, exec, ghostty"
      "$mod, D, exec, rofi -show run"
      "$mod, B, exec, rofi -modi emoji -show emoji"
      "$mod SHIFT, D, exec, rofi -show drun"
      "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
      "$mod CTRL, L, exec, hyprlock"
      "$mod, P, exec, pass-choose"
      "$mod, O, exec, otp-choose"

      "$mod SHIFT, R, exec, hyprctl reload"
      "$mod SHIFT, E, exec, hyprctl dispatch exit"

      ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
      ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86MonBrightnessDown, exec, light -s sysfs/backlight/amdgpu_bl1 -U 5"
      ", XF86MonBrightnessUp, exec, light -s sysfs/backlight/amdgpu_bl1 -A 5"
      ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
      ", XF86AudioMedia, exec, mate-calc"
    ]
    ++ workspaceBinds;

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };

  submapsConfig = ''
    submap = resize
    bind = , H, resizeactive, -10 0
    bind = , L, resizeactive, 10 0
    bind = , K, resizeactive, 0 -10
    bind = , J, resizeactive, 0 10
    bind = , RETURN, submap, reset
    bind = , ESCAPE, submap, reset
    bind = $mod, R, submap, reset
    submap = reset
  '';

  windows = {
    windowrule = [
      "float on, match:class R_x11"
      "float on, match:class Thunar"
      "float on, match:class Lxappearance"
      "float on, match:class gnome-calculator"
    ];
  };

  startup = {
    exec-once = [
      "hypridle"
      "hyprpaper"
      "nm-applet"
      "easyeffects --hide-window --load-preset fw13-easy-effects"
      "blueberry-tray"
      "hyprsunset"
      "nextcloud"
    ];
  };

  monitors = {
    monitor = [
      ",preferred,auto,1.33"
    ];
  };
in
{
  options.modules.wayland.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland via home-manager";
  };

  config = lib.mkIf hyprland.enable {
    modules.wayland.waybar.enable = lib.mkForce true;
    modules.wayland.hyprpaper.enable = lib.mkForce true;
    modules.graphical.rofi.enable = lib.mkForce true;
    modules.graphical.dunst.enable = lib.mkForce true;

    services.ssh-agent.enable = true;

    home.packages = [ pkgs.wl-clipboard-rs ];
    programs.zsh.shellAliases = {
      pbcopy = "${pkgs.wl-clipboard-rs}/bin/wl-copy";
      pbpaste = "${pkgs.wl-clipboard-rs}/bin/wl-paste";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      # Remove in NixOS
      package = null;
      configType = "hyprlang";
      xwayland.enable = true;
      systemd.enable = true;
      settings = variables // look // layout // input // binds // windows // startup // monitors;
      extraConfig = submapsConfig;
    };
  };
}
