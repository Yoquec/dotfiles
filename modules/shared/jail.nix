{ flake, pkgs, ... }:
let
  inherit (flake.inputs) jail-nix;
  jail-lib = import ../../lib/jail.nix { inherit pkgs; };
in
{
  _module.args.jail = jail-nix.lib.extend {
    inherit pkgs;
    additionalCombinators = jail-lib.combinators;
  };
}
