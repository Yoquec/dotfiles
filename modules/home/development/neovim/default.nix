{
  lib,
  pkgs,
  config,
  flake,
  ...
}:
{
  imports = [
    flake.inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./ftplugins.nix
    ./plugins/theme.nix
    ./plugins/treesitter.nix
    ./plugins/misc.nix
    ./plugins/gitsigns.nix
    ./plugins/diffview.nix
    ./plugins/snippets.nix
    ./plugins/blink.nix
    ./plugins/lsp.nix
    ./plugins/formatter.nix
    ./plugins/snacks.nix
    ./plugins/zk.nix
  ];

  options.modules.development.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
  };

  config = lib.mkIf config.modules.development.neovim.enable {
    programs.neovim.defaultEditor = true;

    programs.nixvim = {
      enable = true;

      extraPlugins = [ pkgs.vimPlugins.yoquec ];
    };
  };
}
