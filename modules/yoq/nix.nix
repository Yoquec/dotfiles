# https://nixos.org/manual/nix/stable/command-ref/conf-file.html
{ lib, burrow, ... }:
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
    # standalone home-manager (e.g. a non-nixos linux distribution) won't use
    # `settings` via nixos/darwin above, so cover it here instead. Gated on
    # {home, ...} so this is inert for host-bound users -- those already get
    # `settings` via nixos/darwin and don't need a second, redundant GC timer.
    includes = [
      burrow.base
      provides.home-manager-standalone-nix
    ];

    nixos = settings;
    darwin = settings;
    provides.home-manager-standalone-nix =
      { home, ... }:
      {
        homeManager = settings // {
          # standalone installs need home-manager's own CLI to run switches,
          # since there's no nixos/darwin-rebuild to drive activation for them.
          programs.home-manager.enable = true;
        };
      };
  };
}
