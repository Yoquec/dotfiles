# Adds a series of nice to have language servers
{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.languageservers.enable = lib.mkEnableOption "Enable default languageservers";

  config = lib.mkIf config.modules.languageservers.enable {
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
      nodePackages.prettier
      shfmt
    ];
  };
}
