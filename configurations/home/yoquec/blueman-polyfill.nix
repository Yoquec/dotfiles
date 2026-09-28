# HACK: Copies over the blueman package but replaces its bin/
# with scripts that run archlinux-installed binaries
{
  blueman,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  inherit (blueman) meta version pname;
  name = "blueman-polyfill";
  src = blueman;
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  unpackPhase = ''
    cp -rs --no-preserve=mode $src $out
  '';
  installPhase = ''
    binaries=$(ls $out/bin/*)
    rm -f $out/bin/*

    for f in $binaries*; do
        file=$(basename $f)
        dest="$out/bin/$file"
        printf '%s\n' '#!/usr/bin/bash' "/usr/bin/$file \"\$@\"" > "$dest"
        chmod +x "$dest"
    done
  '';
}
