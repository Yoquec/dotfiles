{
  lib,
  config,
  ...
}:
let
  enable = config.modules.media.enable;
in
{
  imports = [
    ./yt-dlp.nix
    ./ncspot.nix
    ./protonmail.nix
    ./tidal.nix
    ./nextcloud-client.nix
  ];

  options.modules.media.enable = lib.mkEnableOption "Enable media bundle";

  config.modules.media = {
    enable = lib.mkDefault false;
    ncspot.enable = lib.mkDefault enable;
    protonmail.enable = lib.mkDefault enable;
    tidal.enable = lib.mkDefault enable;
    nextcloud-client.enable = lib.mkDefault enable;

    yt-dlp = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault false;
    };
  };
}
