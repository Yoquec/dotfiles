{ ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    keymaps = [
      # Movement
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Moves the selection one line down";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Moves the selection one line up";
      }
      {
        mode = "v";
        key = "H";
        action = "<gv";
        options.desc = "Dedents selection";
      }
      {
        mode = "v";
        key = "L";
        action = ">gv";
        options.desc = "Indents selection";
      }

      # Copying and pasting
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>y";
        action = ''"+y'';
        options.desc = "Copy into the system register";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>p";
        action = ''"+p'';
        options.desc = "Paste from the system register";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>P";
        action = ''"+P'';
        options.desc = "Prepend paste from the system register";
      }
      {
        mode = "v";
        key = "P";
        action = ''"_dP'';
        options.desc = "Paste without populating the register with the selection";
      }

      # Windows
      {
        mode = "n";
        key = "<A-C-j>";
        action = ":resize -2<CR>";
        options.desc = "Resize window down";
      }
      {
        mode = "n";
        key = "<A-C-k>";
        action = ":resize +2<CR>";
        options.desc = "Resize window up";
      }
      {
        mode = "n";
        key = "<A-C-h>";
        action = ":vertical resize -2<CR>";
        options.desc = "Resize window left";
      }
      {
        mode = "n";
        key = "<A-C-l>";
        action = ":vertical resize +2<CR>";
        options.desc = "Resize window right";
      }

      # Tabs
      {
        mode = "n";
        key = "<leader>mt";
        action.__raw = "vim.cmd.tabnew";
        options.desc = "Open a new tab";
      }
      {
        mode = "n";
        key = "<leader>mn";
        action.__raw = "vim.cmd.tabn";
        options.desc = "Move to the next tab";
      }
      {
        mode = "n";
        key = "<leader>mp";
        action.__raw = "vim.cmd.tabp";
        options.desc = "Move to the previous tab";
      }
      {
        mode = "n";
        key = "<leader>tt";
        action.__raw = ''
          function()
            local barstatus = vim.api.nvim_eval("&showtabline")
            if barstatus < 2 then
              vim.opt.showtabline = 2
            else
              vim.opt.showtabline = 0
            end
          end
        '';
        options.desc = "Toggle tab bar visibility";
      }

      # Misc
      {
        mode = "n";
        key = "<leader>s";
        action = "[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]";
        options.desc = "Rename word under cursor (without lsp)";
      }
      {
        mode = "n";
        key = "<leader>ot";
        action = ''<cmd>execute "tabnew" | execute "terminal" <CR>'';
        options.desc = "Open a terminal in a separate tab";
      }
      {
        mode = "n";
        key = "<BS>";
        action.__raw = "vim.cmd.noh";
        options.desc = "Clear highlight search";
      }
      {
        mode = "n";
        key = "<C-BS>";
        action.__raw = "vim.diagnostic.reset";
        options.desc = "Clear LSP diagnostics";
      }
      {
        mode = "t";
        key = "<esc>";
        action = "<c-\\><c-n>";
        options.desc = "Exit from terminal mode to normal mode";
      }
    ];
  };
}
