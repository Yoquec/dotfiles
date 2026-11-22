{ ... }:
{
  yoq.neovim.homeManager = {
    programs.nixvim = {
      plugins.friendly-snippets.enable = true;
      plugins.luasnip = {
        enable = true;

        fromSnipmate = [ { paths = ./.; } ];
        filetypeExtend = {
          markdown = [ "tex" ];
          typescript = [ "javascript" ];
        };

        luaConfig.post = ''
          local ls = require("luasnip")

          local function jump(direction)
            if vim.snippet.active({ direction = direction }) then
              vim.snippet.jump(direction)
            elseif ls.jumpable(direction) then
              ls.jump(direction)
            end
          end

          local function choice(direction)
            if ls.choice_active() then
              ls.change_choice(direction)
            end
          end

          local function stop()
            local bufnr = vim.api.nvim_get_current_buf()
            if ls.session.current_nodes[bufnr] and not ls.session.jump_active then
              ls.unlink_current()
            else
              vim.snippet.stop()
            end
          end

          vim.keymap.set({ "n", "i", "s" }, "<C-h>", function() jump(-1) end,
            { desc = "Jump to the previous snippet" })
          vim.keymap.set({ "n", "i", "s" }, "<C-l>", function() jump(1) end,
            { desc = "Jump to the next snippet" })
          vim.keymap.set({ "i", "n", "s" }, "<C-k>", function() choice(-1) end,
            { desc = "Cycle to the previous snippet option" })
          vim.keymap.set({ "i", "n", "s" }, "<C-j>", function() choice(1) end,
            { desc = "Cycle to the next snippet option" })
          vim.keymap.set({ "i", "n", "s" }, "<C-q>", stop,
            { desc = "Cancel the current active snippet" })
        '';
      };
    };
  };
}
