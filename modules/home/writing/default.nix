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
    ./emaview.nix
    ./taskwarrior.nix
  ];

  options.modules.writing.enable = lib.mkEnableOption "Enable writing bundle";

  config.modules.writing = {
    enable = lib.mkDefault false;

    wiki.enable = lib.mkDefault enable;
    zk.enable = lib.mkDefault enable;
    emaview.enable = lib.mkDefault enable;
    taskwarrior.enable = lib.mkDefault enable;
  };
}
