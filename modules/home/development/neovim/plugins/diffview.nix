{ ... }:
{
  programs.nixvim = {
    plugins = {
      web-devicons.enable = true;
      diffview.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>do";
        action.__raw = "vim.cmd.DiffviewOpen";
        options.desc = "Open Diffview";
      }
      {
        mode = "n";
        key = "<leader>dq";
        action.__raw = "vim.cmd.DiffviewClose";
        options.desc = "Quit Diffview";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action.__raw = "vim.cmd.DiffviewRefresh";
        options.desc = "Refresh Diffview window";
      }
      {
        mode = "n";
        key = "<leader>dt";
        action.__raw = "vim.cmd.DiffviewToggleFiles";
        options.desc = "Toggle Diffview files";
      }
      {
        mode = "n";
        key = "<leader>dh";
        action.__raw = "vim.cmd.DiffviewFileHistory";
        options.desc = "Open Diffview file history";
      }
    ];
  };
}
