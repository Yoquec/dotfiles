{ ... }:
{
  perSystem =
    { config, pkgs, ... }:
    {
      packages.tmsproject = pkgs.writeShellApplication {
        name = "tmsproject";
        runtimeInputs = [
          pkgs.fzf
          pkgs.tmux
          pkgs.findutils
          config.packages.tms
        ];
        text = builtins.readFile ../bin/tmsproject;
      };
    };
}
