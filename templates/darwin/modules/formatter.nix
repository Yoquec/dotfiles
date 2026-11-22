# treefmt-nix is baked into this module already (see yoquec-dotfiles's
# modules/formatter.nix), so `nix fmt` works without declaring/following
# treefmt-nix as its own input here.
{ inputs, ... }:
{
  imports = [ inputs.yoquec-dotfiles.flakeModules.treefmt ];
}
