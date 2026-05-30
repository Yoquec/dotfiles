{ ... }:
{
  programs.nixvim.opts = {
    termguicolors = true;
    winborder = "rounded";

    nu = true;
    relativenumber = true;

    foldmethod = "indent";
    foldlevel = 99;

    laststatus = 2;
    showmode = true;

    conceallevel = 0;
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    smartindent = true;

    splitright = true;

    wrap = false;

    swapfile = false;
    backup = false;

    undofile = true;
    undodir = [ "$HOME/.cache/nvim/undo" ];

    ignorecase = true;
    hlsearch = true;
    incsearch = true;

    scrolloff = 8;

    signcolumn = "yes";
    background = "dark";

    updatetime = 50;
    spell = true;
    spelllang = [ "en_us" "es_es" ];
  };
}
