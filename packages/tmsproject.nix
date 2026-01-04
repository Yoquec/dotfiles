{
  callPackage,
  writeShellApplication,
  fzf,
  tmux,
  findutils,
  tms ? callPackage ./tms.nix { },
  ...
}:
writeShellApplication {
  name = "tmsproject";
  runtimeInputs = [
    fzf
    tmux
    findutils
    tms
  ];
  text = builtins.readFile ../dotfiles/tmux/bin/tmsproject;
}
