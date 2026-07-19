{
  lib,
  jail,
  config,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
  inherit (config.modules.socials) discord;

  name = "discord";
  dataDir = "${homeDirectory}/.cache/chromium/${name}";
  script = pkgs.writeShellScriptBin name ''
    ${lib.getExe pkgs.ungoogled-chromium} --user-data-dir="${dataDir}" --app=https://discord.com
  '';

  jailed = jail name script (
    with jail.combinators;
    [
      gui
      network
      camera
      (try-readwrite dataDir)
      (add-runtime "mkdir -p ${dataDir}")
      (try-readwrite "${homeDirectory}/Downloads")
    ]
  );
in
{
  options.modules.socials.discord = {
    enable = lib.mkEnableOption "Enable discord desktop application through chromium";
  };

  config.home.packages = lib.mkIf discord.enable [ jailed ];
}
