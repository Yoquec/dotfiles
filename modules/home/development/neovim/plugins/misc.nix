{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.vim-surround ];

    extraLuaPackages = p: [ p.luautf8 ];

    plugins = {
      nvim-autopairs.enable = true;

      which-key = {
        enable = true;
        settings.win.border = "rounded";
      };

      undotree = {
        enable = true;
        settings = { };
      };

      colorizer = {
        enable = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ut";
        action.__raw = "vim.cmd.UndotreeToggle";
        options.desc = "Toggle undotree";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action.__raw = "vim.cmd.ColorizerAttachToBuffer";
        options.desc = "Attach colorizer to the current buffer";
      }
      {
        mode = "n";
        key = "<leader>ct";
        action.__raw = "vim.cmd.ColorizerToggle";
        options.desc = "Toggle colorizer in the current buffer";
      }
      {
        mode = "n";
        key = "<leader>cr";
        action.__raw = "vim.cmd.ColorizerReloadAllBuffers";
        options.desc = "Reload colorizer in all buffers";
      }
      {
        mode = "v";
        key = "<leader>gs";
        action.__raw = ''
          function()
            local utf8 = require("yoquec.core.writting.utf8")
            local replace = require("yoquec.core.writting.replace")
            replace.with(utf8.superscript)()
          end
        '';
        options.desc = "Replace selection with superscript";
      }
    ];
  };
}
