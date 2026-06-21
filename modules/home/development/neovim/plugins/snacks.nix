{ ... }:
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        notifier = {
          enabled = true;
        };
        input = {
          enabled = true;
          b = {
            completions = true;
          };
        };
        explorer = {
          enabled = true;
        };
        picker = {
          enabled = true;
          sources = {
            spelling.layout = {
              preset = "select";
              preview = false;
            };
            search_history.layout = {
              preset = "select";
              preview = false;
            };
            explorer = {
              auto_close = true;
              layout = {
                preset = "ivy";
                preview = "file";
              };
              win.list.keys."%" = "explorer_add";
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>.";
        action.__raw = "function() Snacks.scratch() end";
        options.desc = "Toggle Scratch Buffer";
      }
      {
        mode = "n";
        key = "<leader>S";
        action.__raw = "function() Snacks.scratch.select() end";
        options.desc = "Select Scratch Buffer";
      }

      # File pickers
      {
        mode = "n";
        key = "<leader>ff";
        action.__raw = "function() Snacks.picker.files() end";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>fo";
        action.__raw = "function() Snacks.picker.recent() end";
        options.desc = "Find Old files";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action.__raw = "function() Snacks.picker.buffers() end";
        options.desc = "Find open Buffers";
      }
      {
        mode = "n";
        key = "<leader>fp";
        action.__raw = "function() Snacks.picker.grep() end";
        options.desc = "Find grep Pattern";
      }
      {
        mode = "n";
        key = "<leader>fP";
        action.__raw = "function() Snacks.picker.grep_buffers() end";
        options.desc = "Find grep Pattern in currently open buffers";
      }
      {
        mode = "n";
        key = "<leader>fq";
        action.__raw = "function() Snacks.picker.qflist() end";
        options.desc = "Find elements in the Quickfix list";
      }
      {
        mode = "n";
        key = "<leader>fS";
        action.__raw = "function() Snacks.picker.search_history() end";
        options.desc = "Find Search history";
      }
      {
        mode = "n";
        key = "<leader>fk";
        action.__raw = "function() Snacks.picker.keymaps() end";
        options.desc = "Find Keymaps";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action.__raw = "function() Snacks.picker.help() end";
        options.desc = "Find Help tags";
      }
      {
        mode = "n";
        key = "<leader>f.";
        action.__raw = "function() Snacks.picker.pickers() end";
        options.desc = "Find pickers";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action.__raw = "function() Snacks.picker.commands() end";
        options.desc = "Find Commands";
      }
      {
        mode = "n";
        key = "<leader>fC";
        action.__raw = "function() Snacks.picker.command_history() end";
        options.desc = "Find Command history";
      }
      {
        mode = "n";
        key = "<leader>fm";
        action.__raw = "function() Snacks.picker.marks() end";
        options.desc = "Find Marks";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action.__raw = "function() Snacks.picker.spelling() end";
        options.desc = "Find Spelling suggestions";
      }
      {
        mode = "n";
        key = "<leader>fv";
        action.__raw = "function() Snacks.picker.explorer() end";
        options.desc = "Find files in explorer";
      }

      # Git pickers
      {
        mode = "n";
        key = "<leader>fgs";
        action.__raw = "function() Snacks.picker.git_status() end";
        options.desc = "Find Git Status";
      }
      {
        mode = "n";
        key = "<leader>fgf";
        action.__raw = "function() Snacks.picker.git_files() end";
        options.desc = "Find Git Files";
      }
      {
        mode = "n";
        key = "<leader>fgb";
        action.__raw = "function() Snacks.picker.git_branches() end";
        options.desc = "Find Git Branches";
      }
      {
        mode = "n";
        key = "<leader>fgll";
        action.__raw = "function() Snacks.picker.git_log() end";
        options.desc = "Find Git Commits";
      }
      {
        mode = "n";
        key = "<leader>fglf";
        action.__raw = "function() Snacks.picker.git_log_file() end";
        options.desc = "Find Git Log for current File";
      }
      {
        mode = "n";
        key = "<leader>fglL";
        action.__raw = "function() Snacks.picker.git_log_line() end";
        options.desc = "Find Git Log for current Line";
      }

      # Diagnostic / LSP pickers
      {
        mode = "n";
        key = "<leader>fd";
        action.__raw = "function() Snacks.picker.diagnostics_buffer() end";
        options.desc = "Find buffer Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>fD";
        action.__raw = "function() Snacks.picker.diagnostics() end";
        options.desc = "Find Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>flI";
        action.__raw = "function() Snacks.picker.lsp_implementations() end";
        options.desc = "Find LSP Implementations";
      }
      {
        mode = "n";
        key = "<leader>fld";
        action.__raw = "function() Snacks.picker.lsp_definitions() end";
        options.desc = "Find LSP Definitions";
      }
      {
        mode = "n";
        key = "<leader>flD";
        action.__raw = "function() Snacks.picker.lsp_declarations() end";
        options.desc = "Find LSP Declarations";
      }
      {
        mode = "n";
        key = "<leader>fli";
        action.__raw = "function() Snacks.picker.lsp_incoming_calls() end";
        options.desc = "Find LSP Incoming calls";
      }
      {
        mode = "n";
        key = "<leader>flo";
        action.__raw = "function() Snacks.picker.lsp_outgoing_calls() end";
        options.desc = "Find LSP external function calls";
      }
      {
        mode = "n";
        key = "<leader>flr";
        action.__raw = "function() Snacks.picker.lsp_references() end";
        options.desc = "Find LSP References";
      }
      {
        mode = "n";
        key = "<leader>flt";
        action.__raw = "function() Snacks.picker.lsp_type_definitions() end";
        options.desc = "Find LSP Type definitions";
      }
      {
        mode = "n";
        key = "<leader>fls";
        action.__raw = "function() Snacks.picker.lsp_symbols() end";
        options.desc = "Find LSP document Symbols";
      }
      {
        mode = "n";
        key = "<leader>flS";
        action.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
        options.desc = "Find LSP workspace Symbols";
      }
    ];
  };
}
