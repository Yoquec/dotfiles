{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.socials) netflix;
in
{
  options.modules.socials.netflix = {
    enable = lib.mkEnableOption "Enable netflix desktop application through chormium";
  };

  config.home.packages = lib.mkIf netflix.enable [
    (pkgs.writeShellScriptBin "netflix" ''
      ${pkgs.chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/netflix --app=https://netflix.com
    '')
  ];
}
