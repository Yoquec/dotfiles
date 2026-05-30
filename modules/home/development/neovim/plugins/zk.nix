{ lib, pkgs, config, ... }:
lib.mkIf config.modules.writing.wiki.enable {
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.zk-nvim ];

    extraConfigLua = ''
      local function with_title(cb)
        vim.ui.input({ prompt = "Title" }, function(title)
          if title == nil or title == "" then
            print("Operation canceled")
          else
            cb(title)
          end
        end)
      end

      require("zk").setup({ picker = "snacks_picker" })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>zz";
        action.__raw = "vim.cmd.ZkNotes";
        options.desc = "Open notes";
      }
      {
        mode = "n";
        key = "<leader>zo";
        action = "<Cmd>ZkNotes { sort = { 'modified' } }<cr>";
        options.desc = "Open recent notes";
      }
      {
        mode = "n";
        key = "<leader>zt";
        action.__raw = "vim.cmd.ZkTags";
        options.desc = "Open tags";
      }
      {
        mode = "n";
        key = "<leader>zB";
        action.__raw = "vim.cmd.ZkBacklinks";
        options.desc = "Backlinks for current note";
      }
      {
        mode = "n";
        key = "<leader>zl";
        action.__raw = "vim.cmd.ZkLinks";
        options.desc = "Links for current note";
      }
      {
        mode = "n";
        key = "<leader>zL";
        action.__raw = "vim.cmd.ZkInsertLink";
        options.desc = "Insert a link under the cursor";
      }
      {
        mode = "n";
        key = "<leader>zb";
        action.__raw = "vim.cmd.ZkBuffers";
        options.desc = "Open picker with open note buffers";
      }
      {
        mode = "v";
        key = "<leader>zL";
        action = "<cmd>'<,'>ZkInsertLinkAtSelection { sort = {'modified' } }<cr>";
        options.desc = "Insert a link over the current selection";
      }
      {
        mode = "v";
        key = "<leader>zft";
        action = "<cmd>'<,'>ZkNewFromTitleSelection<cr>";
        options.desc = "Create new note using the selected content as title";
      }
      {
        mode = "v";
        key = "<leader>zfc";
        action.__raw = ''
          function()
            vim.ui.input({ prompt = "Title" }, function(title)
              if title == nil or title == "" then
                print("Operation canceled")
              else
                vim.cmd([['<,'>ZkNewFromContentSelection { title = ']] .. title .. [[' }]])
              end
            end)
          end
        '';
        options.desc = "Create new note with the selected content";
      }
      {
        mode = "n";
        key = "<leader>zn";
        action.__raw = ''
          function()
            vim.ui.input({ prompt = "Title" }, function(title)
              if title == nil or title == "" then
                print("Operation canceled")
              else
                local new = require("zk.commands").get("ZkNew")
                new({ title = title })
              end
            end)
          end
        '';
        options.desc = "Create a new zettlekasten note";
      }
    ];
  };
}
