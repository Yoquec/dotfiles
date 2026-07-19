{
  lib,
  jail,
  config,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
  inherit (config.modules.socials) whatsapp;

  name = "whatsapp";
  dataDir = "${homeDirectory}/.cache/chromium/${name}";

  script = pkgs.writeShellScriptBin name ''
    ${lib.getExe pkgs.ungoogled-chromium} --user-data-dir="${dataDir}" --app=https://web.whatsapp.com
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
  options.modules.socials.whatsapp = {
    enable = lib.mkEnableOption "Enable whatsapp desktop application through chromium";
  };

  config.home.packages = lib.mkIf whatsapp.enable [ jailed ];
}
