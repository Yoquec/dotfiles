# Jails a browser into an "app mode" launcher + desktop entry, as one package.
{ ... }:
{
  flake.lib.mkContainerizedWebapp =
    {
      pkgs,
      lib,
      jail,
      homeDirectory,
    }:
    {
      name,
      browser,
      url,
      description,
      extraCombinators ? [ ],
    }:
    let
      dataDir = "${homeDirectory}/.cache/chromium/${name}";

      exe =
        pkgs.runCommand name
          {
            nativeBuildInputs = [ pkgs.makeWrapper ];
            meta.mainProgram = name;
          }
          ''
            makeWrapper ${lib.getExe browser} $out/bin/${name} \
              --add-flags ${lib.escapeShellArg "--app=${url} --user-data-dir=${dataDir}"}
          '';

      jailed = jail name exe (
        with jail.combinators;
        [
          gui
          network
          (try-readwrite dataDir)
          (add-runtime "mkdir -p ${dataDir}")
        ]
        ++ extraCombinators
      );

      desktopItem = pkgs.makeDesktopItem {
        inherit name;
        exec = name;
        desktopName = description;
        comment = description;
      };
    in
    pkgs.symlinkJoin {
      inherit name;
      paths = [
        jailed
        desktopItem
      ];
    };
}
