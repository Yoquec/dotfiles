{ inputs, ... }:
{
  flake-file.inputs.treefmt-nix.url = "github:numtide/treefmt-nix";

  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    programs.nixfmt.enable = true;
    settings.global.excludes = [
      "*.qcow2"
      "flake.lock"
    ];
  };
}
