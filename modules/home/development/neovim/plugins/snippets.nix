{ ... }:
{
  programs.nixvim = {
    plugins.luasnip.enable = true;

    extraFiles = {
      "snippets/markdown.snippets".text = ''
        snippet box "Insert a checkbox ☑"
        	- [''${1: }] $0
      '';
      "snippets/javascript.snippets".text = ''
        snippet afee "Anonymous arrow function"
        	(''${1:}) => {
        		''${2:}
        	}$0
        snippet /// "JSDoc comment"
        	/**
        	 * $0
        	 */
      '';
      "snippets/gitcommit.snippets".text = ''
        snippet coauthor "Co-Authored commit"
        	Co-authored-by: ''${1:Name} <''${2:name@example.com}>
      '';
    };

    extraConfigLua = ''
      local ls = require("luasnip")
      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load()

      ls.filetype_extend("markdown", { "tex" })
      ls.filetype_extend("typescript", { "javascript" })

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
}
