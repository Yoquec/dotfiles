# Shared nixvim bootstrap
{ inputs, ... }:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim/nixos-26.05";
  burrow.nixvim.homeManager = {
    imports = [ inputs.nixvim.homeModules.nixvim ];
  };
}
