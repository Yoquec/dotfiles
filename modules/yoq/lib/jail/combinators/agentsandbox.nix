# Tools for sandboxed agents
{ ... }:
{
  yoq.lib.jail.combinators =
    { pkgs, lib, ... }:
    [
      (builtin: {
        agentsandbox = {
          neovim = builtin.compose (
            with builtin;
            [
              (set-env "EDITOR" "nvim --clean")
              (add-pkg-deps [ pkgs.neovim ])
            ]
          );

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
