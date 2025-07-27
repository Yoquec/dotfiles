{
  lib,
  config,
  neovim,
  ...
}: {
  options.modules.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
    installBinary = lib.mkEnableOption "Install neovim binary with nix";
  };

  config = lib.mkIf config.modules.neovim.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
      WIKI_HOME = "$HOME/Nextcloud/Notes/";
    };

    home.file = {
      ".config/nvim".source = neovim;
    };

    programs.neovim.enable = config.modules.neovim.installBinary;
  };
}
