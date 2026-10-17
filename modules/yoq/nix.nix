# https://nixos.org/manual/nix/stable/command-ref/conf-file.html
{ lib, ... }:
let
  settings = {
    nix.settings.experimental-features = lib.mkDefault [
      "nix-command"
      "flakes"
    ];
    nix.gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
in
{
  yoq.nix = rec {
    nixos = settings;
    darwin = settings;

    # Aspect only executed in the context of standalone home-manager.
    # Host bound users will use the configurations above, and won't
    # evaluate the bellow because it executes only in `home` contexts
    # See: https://github.com/denful/den/blob/main/modules/aspects/batteries/user-shell.nix#L43
    includes = [ provides.home-manager-standalone-nix ];
    provides.home-manager-standalone-nix =
      { home, ... }:
      {
        homeManager = settings // {
          # standalone installs need home-manager's CLI to run switches.
          programs.home-manager.enable = true;
        };
      };
  };
}
