{
  root,
  lib,
  config,
  inputs,
  withSystem,
  ...
}:
let
  # TODO: Extract this and devshell.nix into shared lib functions
  vimPluginsDir = root + "/packages/vimPlugins";
  hasDir = builtins.pathExists vimPluginsDir;
  files = lib.optionalAttrs hasDir (
    lib.filterAttrs (n: v: (lib.hasSuffix ".nix" n) && v == "regular") (builtins.readDir vimPluginsDir)
  );
  plugins = lib.mapAttrs' (
    fn: _: lib.nameValuePair (lib.removeSuffix ".nix" fn) (vimPluginsDir + "/${fn}")
  ) files;
in
{
  flake.vimPlugins = lib.genAttrs config.systems (
    system:
    withSystem system (
      { pkgs, ... }:
      lib.mapAttrs (_name: path: pkgs.callPackage path { inherit (inputs) neovim; }) plugins
    )
  );
}
