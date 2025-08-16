{
  lib,
  config,
  ...
}: {
  options.modules.development.fzf = {
    enable = lib.mkEnableOption "Enable fzf";
  };

  config = lib.mkIf config.modules.development.fzf.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = config.modules.development.zsh.enable;
    };
  };
}
