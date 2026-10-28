# https://github.com/nix-community/nh
{ ... }:
let
  nhModule =
    { den, ... }:
    {
      perSystem =
        { pkgs, ... }:
        {
          packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
        };
    };
in
{
  imports = [ nhModule ];
  flake.flakeModules.default = nhModule;
}
