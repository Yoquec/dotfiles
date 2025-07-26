{
  lib,
  config,
  ...
}: {
  options.modules.fontconfig.enable = lib.mkEnableOption "Manage font-config configurations with nix";

  conifg = lib.mkIf config.modules.fontconfig.enable {
    fonts.fontconfig = {
      enable = true;
    };
  };
}
