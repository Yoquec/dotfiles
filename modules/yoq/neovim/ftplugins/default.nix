# Loads ftplugin lua files from the current directory
{ lib, ... }:
let
  dir = ./.;
  luaFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".lua" name) (
    builtins.readDir dir
  );
in
{
  yoq.neovim.homeManager.programs.nixvim.extraFiles = lib.mapAttrs' (
    name: _: lib.nameValuePair "after/ftplugin/${name}" { source = dir + "/${name}"; }
  ) luaFiles;
}
