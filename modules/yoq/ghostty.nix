# https://ghostty.org
{ yoq, ... }:
{
  yoq.ghostty = {
    includes = [ yoq.theme ];

    homeManager =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      let
        inherit (config.lib.stylix) colors;
      in
      {
        programs.ghostty = {
          enable = true;
          package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

          settings = {
            cursor-style = "block";
            cursor-style-blink = false;

            window-padding-x = "20";
            window-padding-y = "25, 5";
          }
          // lib.optionalAttrs pkgs.stdenv.isLinux {
            window-decoration = "server";
            window-theme = "system";
            gtk-titlebar = false;
            gtk-single-instance = true;

            font-style = "Medium";
            font-style-bold = "Bold";
            font-style-italic = "Medium Italic";
            font-style-bold-italic = "Bold Italic";
          }
          // lib.optionalAttrs pkgs.stdenv.isDarwin {
            font-thicken = true;
            macos-titlebar-style = "hidden";
          };
        };

        stylix.targets.ghostty.colors.override = {
          base03 = colors.base02;
          withHashtag.base03 = colors.withHashtag.base02;
        };

        wayland.windowManager.sway.config.terminal = "ghostty";
      };
  };
}
