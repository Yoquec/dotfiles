{
  lib,
  jail,
  config,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
  inherit (config.modules.media) protonmail;

  name = "protonmail";
  dataDir = "${homeDirectory}/.cache/chromium/${name}";

  script = pkgs.writeShellScriptBin name ''
    ${lib.getExe pkgs.ungoogled-chromium} --user-data-dir="${dataDir}" --app=https://mail.proton.me
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
  options.modules.media.protonmail = {
    enable = lib.mkEnableOption "Enable protonmail desktop application through chromium";
  };

  config.home.packages = lib.mkIf protonmail.enable [ jailed ];
}
