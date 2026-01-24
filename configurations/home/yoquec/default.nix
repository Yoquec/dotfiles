{
  flake,
  config,
  pkgs,
  ...
}:
let
  inherit (config) xdg home;
  inherit (flake.inputs) agenix;

  pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVuZC8VJWJKbi+wa3S8iXpp8/6EQZ53e4SBQ5wtWBOS yoquec@framework";

  identity = {
    username = "yoquec";
    fullname = "Alvaro Viejo";
    email = "alvaro.viejo@yoquec.com";
  };
  wiki.directory = "${home.homeDirectory}/Nextcloud/Notes/";
in
{
  imports = [
    ../../../modules/home
    ../../../modules/home/agenix-rekey.nix
    ../../../modules/shared/jail.nix
    ../../../modules/shared/identity.nix
    agenix.homeManagerModules.default
  ];
  inherit identity;

  age.rekey.hostPubkey = pubkey;

  home.username = identity.username;
  home.homeDirectory = "/home/${identity.username}";
  home.stateVersion = "24.11";

  modules.x11.enable = true;
  modules.socials.enable = true;
  modules.development.enable = true;
  modules.development.ai.enable = true;

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
    "${home.homeDirectory}/.xinitrc".source = ../../../dotfiles/xinit/.xinitrc;

    "${xdg.configHome}/rofi".source = ../../../dotfiles/rofi;
    "${xdg.configHome}/dunst".source = ../../../dotfiles/dunst;
    "${xdg.configHome}/ghostty".source = ../../../dotfiles/ghostty;
    "${xdg.configHome}/redshift".source = ../../../dotfiles/redshift;
    "${xdg.configHome}/wireplumber".source = ../../../dotfiles/wireplumber;
  };

  home.packages = with pkgs; [
    age
    ungoogled-chromium
  ];

  programs.zsh.shellAliases = {
    pbcopy = "xclip -sel c";
    pbpaste = "xclip -sel c -o";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
