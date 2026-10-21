# basic development tooling aspects.
{ yoq, burrow, ... }:
{
  yoq.development.includes = [
    burrow.base
    yoq.bat
    yoq.zsh
    yoq.tmux
    yoq.direnv
    yoq.neovim
    yoq.lazygit
    yoq.starship
  ];
}
