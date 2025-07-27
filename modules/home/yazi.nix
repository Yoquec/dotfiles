{
  lib,
  config,
  ...
}: {
  options.modules.yazi = {
    enable = lib.mkEnableOption "Enable yazi";
    installBinary = lib.mkEnableOption "Install yazi binary with nix";
  };

  config = lib.mkIf config.modules.yazi.enable {
    programs.yazi.enable = config.modules.yazi.installBinary;

    programs.zsh.shellAliases = lib.mkIf config.modules.zsh.enable {
      yz = "yazi";
    };

    home.file = {
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
