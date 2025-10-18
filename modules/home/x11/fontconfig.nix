{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.x11) fontconfig;
in
{
  options.modules.x11.fontconfig = {
    enable = lib.mkEnableOption "Manage font-config configurations with nix";
  };

  config = lib.mkIf fontconfig.enable {
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "IntoneMono Nerd Font Mono" ];
        serif = [
          "Libertinus Serif Display"
          "Noto Serif CJK SC"
          "Noto Serif CJK TC"
          "Noto Serif CJK JP"
        ];
        sansSerif = [
          "Inter Display"
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
          "Noto Sans CJK JP"
        ];
      };
    };

    home.packages = with pkgs; [
      # Serif
      libertinus
      noto-fonts-cjk-serif

      # Sans
      inter
      noto-fonts-color-emoji
      noto-fonts-cjk-sans

      # Monospace
      nerd-fonts.intone-mono
    ];
  };
}
