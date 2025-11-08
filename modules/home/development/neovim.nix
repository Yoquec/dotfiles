{
  lib,
  config,
  neovim,
  ...
}:
let
  inherit (config) xdg;
in
{
  options.modules.development.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
    installBinary = lib.mkEnableOption "Install neovim binary with nix";
  };

  config = lib.mkIf config.modules.development.neovim.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.file = {
      "${xdg.configHome}/nvim".source = neovim;
    };

    programs.neovim.enable = config.modules.development.neovim.installBinary;
  };
}
