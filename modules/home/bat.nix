{
  lib,
  config,
  ...
}: {
  options.modules.bat = {
    enable = lib.mkEnableOption "Enable bat as a pager";
    installBinary = lib.mkEnableOption "Install bat binary with nix";
  };

  config = lib.mkIf config.modules.bat.enable {
    home.sessionVariables = {
      PAGER = "bat";
    };

    programs.bat = lib.mkIf config.modules.bat.installBinary {
      enable = true;
      config.theme = "base16";
    };
  };
}
