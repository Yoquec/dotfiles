{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        lua_ls.enable = true;
        lemminx.enable = true;
        taplo.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
        cssls.enable = true;
        html.enable = true;
        eslint.enable = true;
        texlab.enable = true;
        jdtls.enable = true;
        nil_ls.enable = true;
        basedpyright.enable = true;
        gopls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        ts_ls.enable = true;
        emmet_language_server.enable = true;
        hls = {
          enable = true;
          installGhc = false;
        };
        zls.enable = true;
        bashls.enable = true;
        coq_lsp = {
          enable = true;
          package = null;
        };
        sourcekit = {
          enable = true;
          package = null;
        };
        gleam.enable = true;
        clangd.enable = true;
      };
    };

    extraPackages = with pkgs; [
      nil
      harper
      lemminx
      taplo
      texlab
      alejandra
      yaml-language-server
      vscode-langservers-extracted
      emmet-language-server
      bash-language-server
    ];

    extraConfigLua = ''
      -- TODO: move smithy, tsp_server to plugins.lsp.servers when nixvim adds built-in modules for them
      vim.lsp.config("smithy", {
        cmd = { "smithy-language-server" },
        filetypes = { "smithy" },
        root_markers = { ".smithy-project.json", "smithy-build.json", "build.gradle", "build.gradle.kts", ".git" },
        message_level = vim.lsp.protocol.MessageType.Log,
        init_options = {
          statusBarProvider = "show-message",
          isHttpEnabled = true,
          compilerOptions = { snippetAutoIndent = false },
        },
      })
      vim.lsp.enable({ "smithy", "tsp_server" })

      vim.lsp.config("emmet_language_server", {
        filetypes = vim.list_extend({ "markdown", "rmarkdown" }, vim.lsp.config.emmet_language_server.filetypes),
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.HINT] = "●",
            [vim.diagnostic.severity.INFO] = "●",
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if not client then
            return
          end

          local opts = { bufnr = args.buf, id = client.id }

          vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, {
            unpack(opts),
            desc = "LSP jump to Definition",
          })

          vim.keymap.set("n", "grr", Snacks.picker.lsp_references, {
            unpack(opts),
            desc = "LSP References",
          })

          vim.keymap.set("n", "gI", Snacks.picker.lsp_references, {
            unpack(opts),
            desc = "LSP Implementations",
          })

          vim.keymap.set("n", "gO", Snacks.picker.lsp_symbols, {
            unpack(opts),
            desc = "LSP buffer symbols",
          })

          vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, {
            unpack(opts),
            desc = "LSP Format",
          })

          vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, {
            unpack(opts),
            desc = "LSP open Diagnostic hover",
          })

          vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, {
            unpack(opts),
            desc = "LSP go to previous Diagnostic",
          })

          vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, {
            unpack(opts),
            desc = "LSP go to next Diagnostic",
          })
        end,
      })
    '';
  };
}
