# https://github.com/jesseduffield/lazygit
{ yoq, ... }:
{
  yoq.lazygit = {
    includes = [
      yoq.git
      yoq.theme
    ];

    homeManager = {
      programs.lazygit.enable = true;
      home.shellAliases = {
        lg = "lazygit";
      };
    };
  };
}
