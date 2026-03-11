# Sets up shared modules
{ ... }:
{
  flake.sharedModules = {
    identity = ../shared/identity.nix;
    theme = ../shared/theme.nix;
  };
}
