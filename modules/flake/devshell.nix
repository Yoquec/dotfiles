{ ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [
          config.agenix-rekey.package
          pkgs.age-plugin-yubikey
        ];
      };
    };
}
