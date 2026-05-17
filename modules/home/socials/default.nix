{
  lib,
  config,
  ...
}:
let
  inherit (config.modules.socials) enable;
in
{
  imports = [
    ./whatsapp.nix
    ./discord.nix
    ./netflix.nix 
  ];

  options.modules.socials.enable = lib.mkEnableOption "Enable social media bundle";

  config.modules.socials = {
    enable = lib.mkDefault false;
    whatsapp.enable = lib.mkDefault enable;
    discord.enable = lib.mkDefault enable;
    netflix.enable = lib.mkDefault enable;
  };
}
