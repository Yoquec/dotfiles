{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.media) protonmail;
in
{
  options.modules.media.protonmail = {
    enable = lib.mkEnableOption "Enable protonmail desktop application through chormium";
  };

  config.home.packages = lib.mkIf protonmail.enable [
    (pkgs.writeShellScriptBin "protonmail" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/protonmail --app=https://mail.proton.me
    '')
  ];
}
