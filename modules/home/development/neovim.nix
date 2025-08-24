{
  lib,
  config,
  neovim,
  ...
}: {
  options.modules.development.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
    installBinary = lib.mkEnableOption "Install neovim binary with nix";
  };

  config = lib.mkIf config.modules.development.neovim.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.file = {
      ".config/nvim".source = neovim;
    };

    programs.neovim.enable = config.modules.development.neovim.installBinary;
  };
}
