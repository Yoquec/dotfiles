{ ... }:
{
  yoq.neovim.homeManager = {
    programs.nixvim.plugins.treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
        indent.enable = true;
      };
    };
  };
}
