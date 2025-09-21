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
    ./disneyplus.nix
  ];

  options.modules.socials.enable = lib.mkEnableOption "Enable social media bundle";

  config.modules.socials = {
    enable = lib.mkDefault true;
    whatsapp.enable = lib.mkDefault enable;
    discord.enable = lib.mkDefault enable;
    disneyplus.enable = lib.mkDefault enable;
  };
}
