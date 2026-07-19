{
  lib,
  jail,
  config,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
  inherit (config.modules.media) tutanota;

  name = "tutanota";
  dataDir = "${homeDirectory}/.cache/chromium/${name}";

  script = pkgs.writeShellScriptBin name ''
    ${lib.getExe pkgs.ungoogled-chromium} --user-data-dir="${dataDir}" --app=https://mail.tutanota.com
  '';

  jailed = jail name script (
    with jail.combinators;
    [
      gui
      network
      (try-readwrite dataDir)
      (add-runtime "mkdir -p ${dataDir}")
      (try-readwrite "${homeDirectory}/Downloads")
    ]
  );
in
{
  options.modules.media.tutanota = {
    enable = lib.mkEnableOption "Enable tutanota desktop application through chromium";
  };
  config.home.packages = lib.mkIf tutanota.enable [ jailed ];
}
