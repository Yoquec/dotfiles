{
  lib,
  config,
  ...
}: {
  options.modules.direnv = {
    enable = lib.mkEnableOption "Enable direnv";
  };

  config = lib.mkIf config.modules.direnv.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = config.modules.zsh.enable;
    };
  };
}
