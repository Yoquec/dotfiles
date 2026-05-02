{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.media) brain-fm;
in
{
  options.modules.media.brain-fm = {
    enable = lib.mkEnableOption "Enable nextcloud client desktop application through chormium";
  };

  config.home.packages = lib.mkIf brain-fm.enable [
    (pkgs.writeShellScriptBin "brain-fm" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/brain-fm --app=https://my.brain.fm
    '')
  ];
}
