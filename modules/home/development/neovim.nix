{
  lib,
  pkgs,
  config,
  flake,
  ...
}:
let
  inherit (flake.inputs) neovim;
  inherit (config) xdg;
in
{
  options.modules.development.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
    installBinary = lib.mkEnableOption "Install neovim binary with nix";
  };

  config = lib.mkIf config.modules.development.neovim.enable {
    programs.neovim.defaultEditor = true;

    home.file = {
      "${xdg.configHome}/nvim".source = neovim;
    };

    programs.neovim = {
      enable = config.modules.development.neovim.installBinary;
      extraPackages = with pkgs; [ texttransform ];

      # HACK: Leverage `extraWrapperArgs` to wire in the
      # theme overrides
      # See: https://nix-community.github.io/home-manager/options.xhtml#opt-programs.neovim.extraWrapperArgs
      extraWrapperArgs = [
        "--suffix"
        "THEME"
        ":"
        "${config.theme}"
      ];
    };
  };
}
