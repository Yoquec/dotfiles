{
  lib,
  config,
  flake,
  pkgs,
  ...
}:
let
  inherit (config) theme;
  inherit (config.modules) stylix;
in
{
  imports = [ flake.inputs.stylix.homeModules.stylix ];

  options.modules.stylix = {
    enable = lib.mkEnableOption "System-wide theming via stylix";
  };

  config = lib.mkIf stylix.enable {
    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      autoEnable = true;
      polarity = if theme == "light" then "light" else "dark";
      image = ../../assets/wallpapers/charcoal_creation_of_adam.png;

      base16Scheme = {
        scheme = "Tomorrow Night Bright";
        author = "Chris Kempson, Alvaro Viejo";
        base00 = "#000000";
        base01 = "#2a2a2a";
        base02 = "#424242";
        base03 = "#969896";
        base04 = "#c3c3c3";
        base05 = "#eaeaea";
        base06 = "#f5f5f5";
        base07 = "#ffffff";
        base08 = "#d54e53";
        base09 = "#e78c45";
        base0A = "#e7c547";
        base0B = "#b9ca4a";
        base0C = "#70c0b1";
        base0D = "#7aa6da";
        base0E = "#c397d8";
        base0F = "#e7c547";
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.intone-mono;
          name = "IntoneMono Nerd Font Mono";
        };
        sansSerif = {
          package = pkgs.inter;
          name = "Inter Display";
        };
        serif = {
          package = pkgs.libertinus;
          name = "Libertinus Serif Display";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
