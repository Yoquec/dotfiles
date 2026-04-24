{
  agenix-rekey,
  age-plugin-yubikey,
  mkShellNoCC,
  ...
}:
mkShellNoCC {
  nativeBuildInputs = [
    agenix-rekey
    age-plugin-yubikey
  ];
}
