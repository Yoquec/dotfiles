{
  ghostty,
  writeShellScriptBin,
  stdenvNoCC,
  ...
}:
let
  polyfill = writeShellScriptBin "ghostty" ''
    /usr/bin/ghostty "$@"
  '';
in
stdenvNoCC.mkDerivation {
  inherit (ghostty) meta version pname;
  name = "ghostty-polyfill";
  src = ghostty;

  phases = [
    "unpackPhase"
    "installPhase"
  ];
  unpackPhase = ''
    cp -rs --no-preserve=mode $src $out
  '';
  installPhase = ''
    rm $out/bin/ghostty
    install -v ${"${polyfill}/bin/ghostty"} $out/bin/ghostty
  '';
}
