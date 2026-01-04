{
  writeShellApplication,
  tmux,
  procps,
  ...
}:
writeShellApplication {
  name = "tms";
  runtimeInputs = [
    tmux
    procps
  ];
  text = builtins.readFile ../dotfiles/tmux/bin/tms;
}
