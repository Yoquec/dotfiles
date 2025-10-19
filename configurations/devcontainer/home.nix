# Home manager configuration to use in a dev container
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

  home.packages = with pkgs; [
    gcc
  ];

  modules = {
    x11.enable = false;
    writing.enable = false;
    media.enable = false;
    socials.enable = false;
    development = {
      helix.enable = false;
      nix.installBinary = false;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
