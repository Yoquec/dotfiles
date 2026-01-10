# Custom configuration (e.g. combinators) for jail.nix
# See: https://alexdav.id/projects/jail-nix/advanced-configuration/#additionalcombinators

{ pkgs, ... }:
{
  combinators = builtin: {
    tools = {
      git = (builtin.add-pkg-deps [ pkgs.git ]);
      bash = builtin.compose (
        let
          shell = pkgs.bashNonInteractive;
        in
        [
          (builtin.set-env "SHELL" "${shell}/bin/bash")
          (builtin.add-pkg-deps [ shell ])
        ]
      );
    };
  };
}
