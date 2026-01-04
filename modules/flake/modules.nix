# Sets up shared modules
{ ... }:
{
  flake.sharedModules = {
    identity = ../shared/identity.nix;
  };
}
