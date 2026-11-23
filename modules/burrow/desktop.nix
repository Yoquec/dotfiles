{ yoq, burrow, ... }:
{
  burrow.desktop = {
    includes = [
      yoq.theme
      burrow.sway
      burrow.file-manager
      burrow.polkit
      burrow.portals
      burrow.zathura
      burrow.feh
      burrow.network-manager-applet
      burrow.audio
      burrow.input
      burrow.notifications
      burrow.bluetooth
    ];

    homeManager =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      let
        inherit (config.yoq.theme) polarity;
      in
      {
        fonts.fontconfig.enable = true;

        stylix.fonts = {
          monospace = lib.mkDefault {
            package = pkgs.nerd-fonts.intone-mono;
            name = "IntoneMono Nerd Font Mono";
          };
          sansSerif = {
            package = pkgs.inter;
            name = "Inter";
          };
          serif = {
            package = pkgs.libertinus;
            name = "Libertinus Serif";
          };
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };

        gtk.iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = if polarity == "dark" then "Papirus-Dark" else "Papirus-Light";
        };
      };
  };
}
