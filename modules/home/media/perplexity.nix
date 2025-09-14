{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.media) perplexity;
in
{
  options.modules.media.perplexity = {
    enable = lib.mkEnableOption "Enable perplexity desktop application through chormium";
  };

  config.home.packages = lib.mkIf perplexity.enable [
    (pkgs.writeShellScriptBin "perplexity" ''
      ${pkgs.ungoogled-chromium}/bin/chromium --user-data-dir=$HOME/.cache/chromium/perplexity --app=https://perplexity.ai
    '')
  ];
}
