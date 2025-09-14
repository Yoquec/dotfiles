{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.media) nextcloud-client;
in
{
  options.modules.media.nextcloud-client = {
    enable = lib.mkEnableOption "Enable nextcloud client desktop application through chormium";
  };

  config.home.packages = lib.mkIf nextcloud-client.enable [
    (pkgs.writeShellScriptBin "nextcloud-client" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/nextcloud-client --app=https://cloud.yoquec.com
    '')
  ];
}
