{
  perSystem =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        nativeBuildInputs = [
          config.agenix-rekey.package
          pkgs.age-plugin-yubikey
        ];
      };
    };
}
