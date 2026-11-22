{ ... }:
{
  yoq.lib.jail.combinators =
    { pkgs, lib, ... }:
    [
      (builtin: {
        tools = {
          git = builtin.add-pkg-deps [ pkgs.git ];

          bash = builtin.compose (
            let
              shell = pkgs.bashNonInteractive;
            in
            [
              (builtin.set-env "SHELL" (lib.getExe' shell "bash"))
              (builtin.add-pkg-deps [
                shell
                pkgs.coreutils
                pkgs.gnugrep
                pkgs.gnused
                pkgs.findutils
                pkgs.curl
                pkgs.wget
                pkgs.which
              ])
            ]
          );
        };
      })
    ];
}
