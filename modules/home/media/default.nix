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
  ];

  options.modules.media.enable = lib.mkEnableOption "Enable media bundle";

  config.modules.media = {
    enable = lib.mkDefault true;
    ncspot.enable = lib.mkDefault enable;

    yt-dlp = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault false;
    };
  };
}
