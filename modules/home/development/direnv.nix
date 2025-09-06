{
  lib,
  config,
  ...
}:
{
  options.modules.development.direnv = {
    enable = lib.mkEnableOption "Enable direnv";
  };

  config = lib.mkIf config.modules.development.direnv.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = config.modules.development.zsh.enable;
    };
  };
}
