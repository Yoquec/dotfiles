# https://github.com/nix-community/nixvim
{ inputs, yoq, ... }:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim/nixos-26.05";

  yoq.neovim = {
    includes = [ yoq.theme ];

    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.nixvim.homeModules.nixvim ];
        programs.nixvim = {
          enable = true;
          defaultEditor = true;
          nixpkgs.source = pkgs.path;
        };
      };
  };
}
