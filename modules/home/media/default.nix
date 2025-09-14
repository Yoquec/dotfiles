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
    ./nextcloud-client.nix
    ./perplexity.nix
  ];

  options.modules.media.enable = lib.mkEnableOption "Enable media bundle";

  config.modules.media = {
    enable = lib.mkDefault true;
    ncspot.enable = lib.mkDefault enable;
    protonmail.enable = lib.mkDefault enable;
    nextcloud-client.enable = lib.mkDefault enable;
    perplexity.enable = lib.mkDefault enable;

    yt-dlp = {
      enable = lib.mkDefault enable;
      installBinary = lib.mkDefault false;
    };
  };
}
