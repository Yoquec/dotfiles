{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.tms = pkgs.writeShellApplication {
        name = "tms";
        runtimeInputs = [
          pkgs.tmux
          pkgs.procps
        ];
        text = builtins.readFile ../bin/tms;
      };
    };
}
