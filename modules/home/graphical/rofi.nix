{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.modules.graphical) rofi;
  inherit (config.lib.formats.rasi) mkLiteral;

  theme = {
    "*" = {
      margin = mkLiteral "1.5";
    };

    window = {
      location = mkLiteral "center";
      width = mkLiteral "512px";
      x-offset = mkLiteral "4px";
      y-offset = mkLiteral "26px";

      padding = mkLiteral "10px 0 0 0";
      border = mkLiteral "1px";
      border-radius = mkLiteral "6px";
    };

    prompt = {
      padding = mkLiteral "0 0 5px 15px";
    };

    textbox = {
      padding = mkLiteral "8px 0px";
      lines = 12;
      columns = 1;
      scrollbar = true;
      fixed-height = false;
      dynamic = false;
    };

    listview = {
      padding = mkLiteral "4px 0px";
    };

    element = {
      padding = mkLiteral "4px 8px";
      spacing = mkLiteral "8px";
    };

    scrollbar = {
      handle-width = mkLiteral "4px";
      padding = mkLiteral "0 4px";
    };
  };

  extraConfig = {
    drun = {
      display-name = " ";
    };
    run = {
      display-name = " ";
    };
    window = {
      display-name = " ";
    };
    timeout = {
      delay = 10;
      action = "kb-cancel";
    };
  };
in
{
  options.modules.graphical.rofi = {
    enable = lib.mkEnableOption "Enable rofi picker";
  };

  config = lib.mkIf rofi.enable {
    programs.rofi = {
      inherit extraConfig theme;
      enable = true;
      pass.enable = true;
      font = lib.mkForce "monospace Bold 10";
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    };

    stylix.targets.rofi = {
      alternatePattern = false;
    };

    wayland.windowManager.sway.config =
      let
        inherit (config.wayland.windowManager.sway.config) modifier;
        rofi = lib.getExe config.programs.rofi.package;
      in
      {
        menu = "${rofi} -show run";
        # HACK: Extend default kkeybindings
        keybindings = lib.mkOptionDefault {
          "${modifier}+b" = "exec ${rofi} -modi emoji -show emoji";
          "${modifier}+Shift+d" = "exec ${rofi} -show drun";
        };
      };
  };
}
