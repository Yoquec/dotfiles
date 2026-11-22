# https://github.com/nixos/nixos-hardware
{ ... }: {
  flake-file.inputs.nixos-hardware = {
    url = "github:NixOS/nixos-hardware/master";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
