# https://github.com/nix-community/stylix
{ inputs, ... }:
{
  flake-file.inputs.stylix.url = "github:nix-community/stylix/release-26.05";

  yoq.theme =
    let
      tomorrowNightBright = {
        scheme = "Tomorrow Night Bright (modified)";
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

      mkPolarityOption =
        lib:
        lib.mkOption {
          type = lib.types.enum [
            "dark"
            "light"
          ];
          default =
            let
              themeEnv = builtins.getEnv "THEME";
            in
            if themeEnv == "dark" || themeEnv == "light" then themeEnv else "dark";
          description = ''
            Light/dark polarity for stylix theming. Defaults to the
            `THEME` environment variable (requires `--impure` to read),
            falling back to "dark" if unset or invalid.
          '';
        };
    in
    {
      # dconf activation (triggered by stylix's gtk/dconf targets) needs the
      # system dbus service registered, or home-manager activation fails with
      # "The name ca.desrt.dconf was not provided by any .service files"
      provides.to-hosts.nixos.programs.dconf.enable = true;

      darwin =
        { lib, ... }:
        {
          options.yoq.theme.polarity = mkPolarityOption lib;
        };

      homeManager =
        {
          pkgs,
          lib,
          config,
          ...
        }:
        let
          inherit (config.yoq.theme) polarity;
        in
        {
          imports = [ inputs.stylix.homeModules.stylix ];

          options.yoq.theme.polarity = mkPolarityOption lib;

          config = {
            fonts.fontconfig.enable = true;

            gtk.iconTheme = {
              package = pkgs.papirus-icon-theme;
              name = if polarity == "dark" then "Papirus-Dark" else "Papirus-Light";
            };

            stylix = {
              inherit polarity;
              enable = true;
              autoEnable = true;

              base16Scheme =
                if polarity == "dark" then
                  tomorrowNightBright
                else
                  "${pkgs.base16-schemes}/share/themes/tomorrow.yaml";

              fonts = {
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
            };
          };
        };
    };
}
