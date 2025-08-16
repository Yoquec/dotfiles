# Adds a series of nice to have language servers
{
  lib,
  pkgs,
  config,
  ...
}: {
  options.modules.development.langservers.enable = lib.mkEnableOption "Enable default languageservers";

  config = lib.mkIf config.modules.development.langservers.enable {
    home.packages = with pkgs; [
      nil
      harper
      lemminx
      taplo
      texlab
      alejandra
      yaml-language-server
      vscode-langservers-extracted
      emmet-language-server
      bash-language-server
    ];
  };
}
