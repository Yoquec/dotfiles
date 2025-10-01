{
  lib,
  config,
  ...
}:
let
  enable = config.modules.development.enable;
in
{
  imports = [
    ./awscli.nix
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./langservers.nix
    ./formatters.nix
    ./lazygit.nix
    ./neovim.nix
    ./helix.nix
    ./nix.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zsh.nix
  ];

  options.modules.development.enable = lib.mkEnableOption "Enable development programs";

  config.modules.development = {
    enable = lib.mkDefault true;

    fzf.enable = lib.mkDefault enable;
    git.enable = lib.mkDefault enable;
    zsh.enable = lib.mkDefault enable;
    tmux.enable = lib.mkDefault enable;
    yazi.enable = lib.mkDefault enable;
    helix.enable = lib.mkDefault enable;
    direnv.enable = lib.mkDefault enable;
    starship.enable = lib.mkDefault enable;
    langservers.enable = lib.mkDefault enable;
    formatters.enable = lib.mkDefault enable;

    nix = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault true;
    };
    awscli = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault true;
    };
    bat = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault true;
    };
    lazygit = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault true;
    };
    neovim = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault true;
    };
  };
}
