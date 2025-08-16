{
  lib,
  config,
  ...
}: {
  options.modules.development.awscli = {
    enable = lib.mkEnableOption "Enable awscli";
    installBinary = lib.mkEnableOption "Install ascli binary with nix";
  };

  config = lib.mkIf config.modules.development.awscli.enable {
    programs.zsh.shellAliases = lib.mkIf config.modules.development.zsh.enable {
      awsc = "aws --cli-auto-prompt";
    };

    programs.awscli.enable = config.modules.development.awscli.installBinary;
  };
}
