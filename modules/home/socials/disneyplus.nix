{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.socials) disneyplus;
in
{
  options.modules.socials.disneyplus = {
    enable = lib.mkEnableOption "Enable disneyplus desktop application through chormium";
  };

  config.home.packages = lib.mkIf disneyplus.enable [
    (pkgs.writeShellScriptBin "disneyplus" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/disneyplus --app=https://disneyplus.com
    '')
  ];
}
