{ config, pkgs, ... }:

{
  home.username = "yoquec";
  home.homeDirectory = "/home/yoquec";

  # WARNING: Might introduce backwards-incompatible changes if modified
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    nil
    harper
    lemminx
    taplo
    yaml-language-server
    jsonnet-language-server
    emmet-language-server
  ];

  # Dotfiles configuration
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
