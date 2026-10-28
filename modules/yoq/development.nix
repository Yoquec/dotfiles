# basic development tooling aspects.
{ yoq, burrow, ... }:
{
  yoq.development.includes = [
    burrow.base
    yoq.nix
    yoq.bat
    yoq.zsh
    yoq.yazi
    yoq.tmux
    yoq.direnv
    yoq.neovim
    yoq.lazygit
    yoq.starship
  ];
}
