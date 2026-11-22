# https://alexdav.id/projects/jail-nix/
{ inputs, ... }:
{
  flake-file.inputs.jail-nix.url = "sourcehut:~alexdavid/jail.nix";

  den.quirks.combinators.description = "jail.nix additional combinators";

  yoq.lib.jail.homeManager =
    {
      pkgs,
      combinators,
      lib,
      ...
    }:
    {
      _module.args.jail = inputs.jail-nix.lib.extend {
        inherit pkgs;
        additionalCombinators =
          builtin: lib.foldl' (acc: f: acc // (f builtin)) { } (lib.flatten combinators);
      };
    };
}
