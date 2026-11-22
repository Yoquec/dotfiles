{ ... }:
{
  yoq.neovim.homeManager = {
    programs.nixvim = {
      plugins.conform-nvim = {
        enable = true;
        autoInstall.enable = true;

        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            typescriptreact = [ "prettier" ];
            html = [ "prettier" ];
            htmldjango = [ "prettier" ];
            css = [ "prettier" ];
            markdown = [ "prettier" ];
            rust = [ "rustfmt" ];
            go = [
              "gofumpt"
              "goimports"
              "golines"
            ];
            python = [
              "black"
              "isort"
            ];
            sql = [ "sleek" ];
            sh = [ "shfmt" ];
          };
        };
      };

      keymaps = [
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader>F";
          action.__raw = ''
            function()
              require("conform").format()
            end
          '';
          options.desc = "conform.nvim format the current file";
        }
      ];
    };
  };
}
