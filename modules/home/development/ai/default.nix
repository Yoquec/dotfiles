{ config, lib, ... }:
let
  inherit (config.modules.development.ai) enable;
in
{
  imports = [
    ./claude-code.nix
  ];

  options.modules.development.ai.enable = lib.mkEnableOption "Enable ai development module";
  config.modules.development.ai = {
    enable = lib.mkDefault false;

    claude-code.enable = lib.mkDefault enable;
  };
}
