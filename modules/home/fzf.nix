{
  lib,
  config,
  ...
}: {
  options.modules.fzf = {
    enable = lib.mkEnableOption "Enable fzf";
  };

  config = lib.mkIf config.modules.fzf.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = config.modules.zsh.enable;
    };
  };
}
