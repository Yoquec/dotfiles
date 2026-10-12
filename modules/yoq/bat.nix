# https://github.com/sharkdp/bat pager
{ yoq, ... }:
{
  yoq.bat = {
    includes = [ yoq.theme ];

    homeManager = {
      programs.bat.enable = true;
      home.sessionVariables = {
        PAGER = "bat --paging=always";
        MANPAGER = "bat -plman";
      };
    };
  };
}
