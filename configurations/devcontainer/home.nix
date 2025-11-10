# Home manager configuration to use in a development container
# See: https://hub.docker.com/r/nixos/nix
{ pkgs, ... }:
let
  identity = {
    username = "root";
    fullname = "Alvaro Viejo";
    email = "alvaro.viejo@yoquec.com";
  };
in
{
  imports = [
    ../../modules/default
  ];
  inherit identity;

  home.username = identity.username;
  home.homeDirectory = "/root";
  home.stateVersion = "24.11";

  modules.development = {
    enable = true;
    helix.enable = false;
    # avoid conflicting with the devcontainer's nix install
    nix.installBinary = false;
  };

  home.packages = with pkgs; [
    fd
    gcc
    curl
    ripgrep
    opencode
    coreutils
  ];

  home.sessionVariables = {
    TERM = "xterm-256color";
  };

  i18n.glibcLocales = pkgs.glibcLocales.override {
    allLocales = false;
    locales = [ "en_US.UTF-8/UTF-8" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
