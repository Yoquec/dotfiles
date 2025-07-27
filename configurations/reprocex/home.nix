# Home manager configuration to use in a dev container
# See: https://hub.docker.com/r/nixos/nix
{...}: let
  identity = {
    username = "root";
    fullname = "Alvaro Viejo";
    email = "alvaro.viejo@yoquec.com";
  };
in {
  imports = [
    ../../modules/home
    ../../modules/identity.nix
  ];
  inherit identity;

  home.username = identity.username;
  home.homeDirectory = "/root";
  home.stateVersion = "24.11";

  modules = {
    nix.enable = true;

    i3.enable = false;
    fontconfig.enable = false;
    yt-dlp.enable = false;

    bat.installBinary = true;
    tmux.installBinary = true;
    yazi.installBinary = true;
    neovim.installBinary = true;
    awscli.installBinary = true;
    lazygit.installBinary = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
