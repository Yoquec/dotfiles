# https://github.com/nix-community/nixvim
{ yoq, burrow, ... }:
{
  yoq.neovim = {
    includes = [
      yoq.theme
      burrow.nixvim
    ];

    homeManager =
      { pkgs, ... }:
      {
        programs.nixvim = {
          enable = true;
          defaultEditor = true;
          nixpkgs.source = pkgs.path;
        };
      };
  };
}
