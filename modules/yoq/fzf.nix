# https://github.com/junegunn/fzf
{ yoq, ... }:
{
  yoq.fzf = {
    includes = [ yoq.theme ];

    homeManager = {
      programs.fzf = {
        enable = true;
      };
    };
  };
}
