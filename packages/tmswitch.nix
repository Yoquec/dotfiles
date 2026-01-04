{
  writeShellApplication,
  fzf,
  tmux,
  gnugrep,
  ...
}:
writeShellApplication {
  name = "tmswitch";
  runtimeInputs = [
    fzf
    tmux
    gnugrep
  ];
  text = builtins.readFile ../dotfiles/tmux/bin/tmswitch;
}
