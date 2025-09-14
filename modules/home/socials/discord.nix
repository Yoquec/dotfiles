{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.socials) discord;
in
{
  options.modules.socials.discord = {
    enable = lib.mkEnableOption "Enable discord desktop application through chormium";
  };

  config.home.packages = lib.mkIf discord.enable [
    (pkgs.writeShellScriptBin "discord" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/discord --app=https://discord.com
    '')
  ];
}
