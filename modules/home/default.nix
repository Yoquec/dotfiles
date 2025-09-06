{ lib, ... }:
{
  imports = [
    ./fontconfig.nix
    ./i3.nix
  ];

  modules.fontconfig.enable = true;

  modules.i3 = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };
}
