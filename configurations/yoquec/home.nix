{ ... }:
let
  identity = {
    username = "yoquec";
    fullname = "Alvaro Viejo";
    email = "alvaro.viejo@yoquec.com";
  };
  wiki.directory = "$HOME/Nextcloud/Notes/";
in
{
  imports = [
    ../../modules/identity.nix
    ../../modules/home
    ../../modules/home/media
    ../../modules/home/writing
    ../../modules/home/development
    ../../modules/home/socials
  ];
  inherit identity;
  modules.writing.wiki = wiki;
  modules.media.ncspot.enable = false;

  home.username = identity.username;
  home.homeDirectory = "/home/${identity.username}";
  home.stateVersion = "24.11";

  nix.gc.dates = "weekly";

  # TODO: Should be moved to their own modules
  home.file = {
    ".xinitrc".source = ../../dotfiles/xinit/.xinitrc;

    ".config/rofi".source = ../../dotfiles/rofi;
    ".config/dunst".source = ../../dotfiles/dunst;
    ".config/ghostty".source = ../../dotfiles/ghostty;
    ".config/redshift".source = ../../dotfiles/redshift;
    ".config/wireplumber".source = ../../dotfiles/wireplumber;
  };

  programs.zsh.shellAliases = {
    pbcopy = "xclip -sel c";
    pbpaste = "xclip -sel c -o";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
