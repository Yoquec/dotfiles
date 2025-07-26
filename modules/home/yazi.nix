{
  lib,
  config,
  ...
}: {
  options.modules.yazi.enable = lib.mkEnableOption "Enable yazi";

  config = lib.mkIf config.modules.yazi.enable {
    programs.yazi.enable = true;
    home.file = {
      ".config/yazi/init.lua".source = ../../dotfiles/yazi/init.lua;
      ".config/yazi/yazi.toml".source = ../../dotfiles/yazi/yazi.toml;
      ".config/yazi/theme.toml".source = ../../dotfiles/yazi/theme.toml;
      ".config/yazi/keymap.toml".source = ../../dotfiles/yazi/keymap.toml;
      ".local/bin/mktms" = {
        executable = true;
        source = ../../dotfiles/yazi/bin/mktms;
      };
    };
  };
}
