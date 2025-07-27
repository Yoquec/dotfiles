{
  lib,
  config,
  ...
}: {
  options.modules.awscli = {
    enable = lib.mkEnableOption "Enable AWSCLI";
    installBinary = lib.mkEnableOption "Install ascli binary with nix";
  };

  config = lib.mkIf config.modules.awscli.enable {
    programs.zsh.shellAliases = lib.mkIf config.modules.zsh.enable {
      awsc = "aws --cli-auto-prompt";
    };

    programs.awscli.enable = config.modules.awscli.installBinary;
  };
}
