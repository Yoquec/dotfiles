{ pkgs, neovim }:
let
  src = pkgs.runCommand "yoquec-src" { } ''
    cp -r ${neovim} $out
    chmod -R u+w $out

    # remove unnecessary modules
    rm $out/lua/yoquec/lazy.lua
    rm $out/init.lua
  '';
in
pkgs.vimUtils.buildVimPlugin {
  name = "yoquec";
  inherit src;
  # luautf8 is a runtime Lua library dependency, not a plugin module
  nvimSkipModule = [ "yoquec.core.writting.utf8" ];
}
