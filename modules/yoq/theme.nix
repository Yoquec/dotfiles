# https://github.com/nix-community/stylix
{ inputs, ... }:
{
  flake-file.inputs.stylix.url = "github:nix-community/stylix/release-26.05";

  yoq.theme =
    let
      # TODO: integrate with theme switching
      polarity = "dark";

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
    in
    {
      # dconf activation (triggered by stylix's gtk/dconf targets) needs the
      # system dbus service registered, or home-manager activation fails with
      # "The name ca.desrt.dconf was not provided by any .service files"
      provides.to-hosts.nixos.programs.dconf.enable = true;

      homeManager =
        { pkgs, ... }:
        {
          imports = [ inputs.stylix.homeModules.stylix ];

          fonts.fontconfig.enable = true;

          stylix = {
            inherit polarity;
            enable = true;
            autoEnable = true;

            base16Scheme =
              if polarity == "dark" then
                tomorrowNightBright
              else
                "${pkgs.base16-schemes}/share/themes/tomorrow.yaml";

            # TODO: point this at your own wallpaper.
            image = ../../assets/wallpapers/wallpaper.png;

            fonts = {
              monospace = {
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
}
