# https://github.com/nix-community/disko
{ inputs, burrow, ... }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  burrow.disko = {
    includes = [ burrow.bootloader ];
    nixos.imports = [ inputs.disko.nixosModules.disko ];
  };
}
