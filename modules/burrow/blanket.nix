# https://github.com/rafaelmardojai/blanket
{ burrow, ... }:
{
  burrow.blanket = {
    includes = [ burrow.graphics ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.blanket ];
      };
  };
}
