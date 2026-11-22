{ inputs, ... }:
let
  devShell =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        nativeBuildInputs = [
          config.agenix-rekey.package
          pkgs.age-plugin-yubikey
        ];
      };
    };
in
{
  imports = [ inputs.agenix-rekey.flakeModule ];
  perSystem = devShell;

  # export the dev shell to consumers
  flake.flakeModules.shell = {
    imports = [ inputs.agenix-rekey.flakeModule ];
    perSystem = devShell;
  };
}
