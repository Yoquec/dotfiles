{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.socials) whatsapp;
in
{
  options.modules.socials.whatsapp = {
    enable = lib.mkEnableOption "Enable whatsapp desktop application through chormium";
  };

  config.home.packages = lib.mkIf whatsapp.enable [
    (pkgs.writeShellScriptBin "whatsapp" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=~/.cache/chromium/whatsapp --app=https://web.whatsapp.com
    '')
  ];
}
