# basic development tooling aspects.
{ yoq, ... }:
{
  yoq.development.includes = [
    yoq.bat
    yoq.fzf
    yoq.zsh
    yoq.tmux
    yoq.direnv
    yoq.neovim
    yoq.lazygit
    yoq.starship
  ];
}
