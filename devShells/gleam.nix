{
  mkShellNoCC,
  gleam,
  erlang,
  ...
}:
mkShellNoCC {
  packages = [
    gleam
    erlang
  ];
}
