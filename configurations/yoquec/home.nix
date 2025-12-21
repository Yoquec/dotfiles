{ config, pkgs, ... }:
let
  inherit (config) xdg home;
  identity = {
    username = "yoquec";
    fullname = "Alvaro Viejo";
    email = "alvaro.viejo@yoquec.com";
  };
  wiki.directory = "${home.homeDirectory}/Nextcloud/Notes/";
in
{
  imports = [
    ../../modules/default
  ];
  inherit identity;

  home.username = identity.username;
  home.homeDirectory = "/home/${identity.username}";
  home.stateVersion = "24.11";

  modules.x11.enable = true;
  modules.socials.enable = true;
  modules.development.enable = true;

  modules.writing = {
    enable = true;
    inherit wiki;
  };

  modules.media = {
    enable = true;
    ncspot.enable = false;
  };

  nix.gc.dates = "weekly";

  # TODO: Should be moved to their own modules
  home.file = {
    "${home.homeDirectory}/.xinitrc".source = ../../dotfiles/xinit/.xinitrc;

    "${xdg.configHome}/rofi".source = ../../dotfiles/rofi;
    "${xdg.configHome}/dunst".source = ../../dotfiles/dunst;
    "${xdg.configHome}/ghostty".source = ../../dotfiles/ghostty;
    "${xdg.configHome}/redshift".source = ../../dotfiles/redshift;
    "${xdg.configHome}/wireplumber".source = ../../dotfiles/wireplumber;
  };

  home.packages = with pkgs; [
    age
    taskwarrior3
    ungoogled-chromium
  ];

  programs.zsh.shellAliases = {
    pbcopy = "xclip -sel c";
    pbpaste = "xclip -sel c -o";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
