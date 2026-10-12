# https://github.com/direnv/direnv
{ ... }:
{
  yoq.direnv.homeManager = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
