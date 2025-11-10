{ pkgs, ... }:
let
  tms = pkgs.writeShellApplication {
    name = "tms";
    runtimeInputs = with pkgs; [
      tmux
      procps
    ];
    text = builtins.readFile ../dotfiles/tmux/bin/tms;
  };
  tmswitch = pkgs.writeShellApplication {
    name = "tmswitch";
    runtimeInputs = with pkgs; [
      fzf
      tmux
      gnugrep
    ];
    text = builtins.readFile ../dotfiles/tmux/bin/tmswitch;
  };
  tmsproject = pkgs.writeShellApplication {
    name = "tmsproject";
    runtimeInputs =
      with pkgs;
      [
        fzf
        tmux
        findutils
      ]
      ++ [ tms ];
    text = builtins.readFile ../dotfiles/tmux/bin/tmsproject;
  };
in
{
  inherit tms tmswitch tmsproject;
}
