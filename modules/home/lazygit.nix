{
  lib,
  config,
  ...
}: {
  options.modules.lazygit = {
    enable = lib.mkEnableOption "Enable lazygit";
    installBinary = lib.mkEnableOption "Install tmux binary with nix";
  };

  config = lib.mkIf config.modules.lazygit.enable {
    programs.lazygit.enable = config.modules.lazygit.installBinary;

    programs.zsh.shellAliases = lib.mkIf config.modules.zsh.enable {
      lg = "lazygit";
    };
  };
}
