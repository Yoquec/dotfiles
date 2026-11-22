{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.tmswitch = pkgs.writeShellApplication {
        name = "tmswitch";
        runtimeInputs = [
          pkgs.fzf
          pkgs.tmux
          pkgs.gnugrep
        ];
        text = builtins.readFile ../bin/tmswitch;
      };
    };
}
