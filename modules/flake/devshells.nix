{
  root,
  lib,
  ...
}:
let
  devShellsDir = root + "/devShells";
  hasDir = builtins.pathExists devShellsDir;
  files = lib.optionalAttrs hasDir (
    lib.filterAttrs (n: v: (lib.hasSuffix ".nix" n) && v == "regular") (builtins.readDir devShellsDir)
  );
  shells = lib.mapAttrs' (
    fn: _: lib.nameValuePair (lib.removeSuffix ".nix" fn) (devShellsDir + "/${fn}")
  ) files;
in
{
  perSystem =
    { pkgs, config, ... }:
    {
      devShells = lib.mapAttrs (
        name: path: pkgs.callPackage path { agenix-rekey = config.agenix-rekey.package; }
      ) shells;
    };
}
