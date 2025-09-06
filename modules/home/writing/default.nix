{
  lib,
  config,
  ...
}:
let
  enable = config.modules.writing.enable;
in
{
  imports = [
    ./wiki.nix
    ./zk.nix
  ];

  options.modules.writing.enable = lib.mkEnableOption "Enable writing bundle";

  config.modules.writing = {
    enable = lib.mkDefault true;

    wiki.enable = lib.mkDefault enable;
    zk.enable = lib.mkDefault enable;
  };
}
