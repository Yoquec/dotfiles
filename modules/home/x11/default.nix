{ lib, config, ... }:
let
  inherit (config.modules.x11) enable;
in
{
  imports = [
    ./i3.nix
    ./fontconfig.nix
  ];

  options.modules.x11 = {
    enable = lib.mkEnableOption "Enable writing bundle";
  };

  config.modules.x11 = {
    enable = lib.mkDefault true;
    fontconfig.enable = lib.mkDefault enable;
    i3 = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault false;
    };
  };
}
