{...}: let
  identity = {
    username = "yoquec";
    fullname = "Alvaro Viejo";
    email = "alvaro.viejo@yoquec.com";
  };
in {
  imports = [
    ../../modules/identity.nix
    ../../modules/home
    ../../modules/home/development
  ];
  inherit identity;

  home.username = identity.username;
  home.homeDirectory = "/home/${identity.username}";
  home.stateVersion = "24.11";

  # TODO: Should be moved to their own modules
  home.file = {
    ".xinitrc".source = ../../dotfiles/xinit/.xinitrc;

    ".config/rofi".source = ../../dotfiles/rofi;
    ".config/dunst".source = ../../dotfiles/dunst;
    ".config/ghostty".source = ../../dotfiles/ghostty;
    ".config/redshift".source = ../../dotfiles/redshift;
    ".config/wireplumber".source = ../../dotfiles/wireplumber;

    ".config/ncspot/config.toml".source = ../../dotfiles/ncspot/config.toml;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
