{
  lib,
  jail,
  config,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
  inherit (config.modules.media) nextcloud-client;

  name = "nextcloud-client";
  dataDir = "${homeDirectory}/.cache/chromium/${name}";

  script = pkgs.writeShellScriptBin name ''
    ${lib.getExe pkgs.ungoogled-chromium} --user-data-dir="${dataDir}" --app=https://cloud.yoquec.com
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
  options.modules.media.nextcloud-client = {
    enable = lib.mkEnableOption "Enable nextcloud client desktop application through chromium";
  };
  config.home.packages = lib.mkIf nextcloud-client.enable [ jailed ];
}
