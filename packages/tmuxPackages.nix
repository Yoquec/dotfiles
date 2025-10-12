{ pkgs, ... }:
{
  tms = pkgs.writeShellApplication {
    name = "tms";
    runtimeInputs = [ pkgs.tmux ];
    text = builtins.readFile ../dotfiles/tmux/bin/tms;
  };
  tmswitch = pkgs.writeShellApplication {
    name = "tmswitch";
    runtimeInputs = [
      pkgs.fzf
      pkgs.tmux
    ];
    text = builtins.readFile ../dotfiles/tmux/bin/tmswitch;
  };
  tmsproject = pkgs.writeShellApplication {
    name = "tmsproject";
    runtimeInputs = [
      pkgs.fzf
      pkgs.tmux
    ];
    text = builtins.readFile ../dotfiles/tmux/bin/tmsproject;
  };
}
