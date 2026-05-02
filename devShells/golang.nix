{
  mkShellNoCC,
  go,
  gofumpt,
  golines,
  gopls,
  delve,
  gotools,
  ...
}:
mkShellNoCC {
  packages = [
    go
    gofumpt
    golines
    gopls
    delve
    gotools
  ];
}
