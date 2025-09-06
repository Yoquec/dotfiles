{
  lib,
  config,
  ...
}:
{
  options.modules.development.lazygit = {
    enable = lib.mkEnableOption "Enable lazygit";
    installBinary = lib.mkEnableOption "Install tmux binary with nix";
  };

  config = lib.mkIf config.modules.development.lazygit.enable {
    programs.lazygit.enable = config.modules.development.lazygit.installBinary;

    programs.zsh.shellAliases = lib.mkIf config.modules.development.zsh.enable {
      lg = "lazygit";
    };
  };
}
