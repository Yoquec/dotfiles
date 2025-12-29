{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.media) tidal;
in
{
  options.modules.media.tidal = {
    enable = lib.mkEnableOption "Enable tidal desktop application through chormium";
  };

  config.home.packages = lib.mkIf tidal.enable [
    (pkgs.writeShellScriptBin "tidal" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/tidal --app=https://listen.tidal.com
    '')
  ];
}
