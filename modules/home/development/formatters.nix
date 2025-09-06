{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.modules.development.formatters.enable = lib.mkEnableOption "Enable default formatters";
  config = lib.mkIf config.modules.development.formatters.enable {
    home.packages = with pkgs; [
      nodePackages.prettier
      shfmt
    ];
  };
}
