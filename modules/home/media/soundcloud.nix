{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.media) soundcloud;
in
{
  options.modules.media.soundcloud = {
    enable = lib.mkEnableOption "Enable soundcloud desktop application through chormium";
  };

  config.home.packages = lib.mkIf soundcloud.enable [
    (pkgs.writeShellScriptBin "soundcloud" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/soundcloud --app=https://soundcloud.com
    '')
  ];
}
