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
    ./protonmail.nix
    ./nextcloud-client.nix
    ./soundcloud.nix
  ];

  options.modules.media.enable = lib.mkEnableOption "Enable media bundle";

  config.modules.media = {
    enable = lib.mkDefault false;
    protonmail.enable = lib.mkDefault enable;
    nextcloud-client.enable = lib.mkDefault enable;
    soundcloud.enable = enable;

    yt-dlp = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault false;
    };
  };
}
