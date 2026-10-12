{ ... }:
{
  yoq.neovim.homeManager =
    { pkgs, lib, ... }:
    {
      programs.nixvim = {
        plugins.lspconfig.enable = true;

        lsp = {
          servers = lib.mapAttrs (_: server: server // { packageFallback = true; }) {
            bashls.enable = true;
            lua_ls.enable = true;
            lemminx.enable = true;
            taplo.enable = true;
            yamlls.enable = true;
            jsonls.enable = true;
            cssls.enable = true;
            html.enable = true;
            texlab.enable = true;
            jdtls.enable = true;
            nil_ls.enable = true;
            ty.enable = true;
            gopls.enable = true;
            tsgo.enable = true;
            zls.enable = true;
            gleam.enable = true;
            clangd.enable = true;
            rust_analyzer.enable = true;
          };

          keymaps = [
            {
              key = "gd";
              action.__raw = "Snacks.picker.lsp_definitions";
              options.desc = "LSP jump to Definition";
            }
            {
              key = "grr";
              action.__raw = "Snacks.picker.lsp_references";
              options.desc = "LSP References";
            }
            {
              key = "gI";
              action.__raw = "Snacks.picker.lsp_references";
              options.desc = "LSP Implementations";
            }
            {
              key = "gO";
              action.__raw = "Snacks.picker.lsp_symbols";
              options.desc = "LSP buffer symbols";
            }
            {
              mode = [
                "n"
                "v"
              ];
              key = "<leader>lf";
              lspBufAction = "format";
              options.desc = "LSP Format";
            }
            {
              key = "<leader>ld";
              action.__raw = "vim.diagnostic.open_float";
              options.desc = "LSP open Diagnostic hover";
            }
            {
              key = "[d";
              action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
              options.desc = "LSP go to previous Diagnostic";
            }
            {
              key = "]d";
              action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
              options.desc = "LSP go to next Diagnostic";
            }
          ];
        };

        diagnostic.settings = {
          virtual_text = true;
          signs.text.__raw = ''
            {
              [vim.diagnostic.severity.ERROR] = "●",
              [vim.diagnostic.severity.WARN] = "●",
              [vim.diagnostic.severity.HINT] = "●",
              [vim.diagnostic.severity.INFO] = "●",
            }
          '';
        };
      };
    };
}
