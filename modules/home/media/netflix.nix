{
  lib,
  jail,
  config,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
  inherit (config.modules.media) netflix;

  name = "netflix";
  dataDir = "${homeDirectory}/.cache/chromium/${name}";
  script = pkgs.writeShellScriptBin name ''
    ${lib.getExe pkgs.google-chrome} --user-data-dir="${dataDir}" --app=https://www.netflix.com
  '';

  jailed = jail name script (
    with jail.combinators;
    [
      unsafe-gui
      (try-readwrite dataDir)
      (add-runtime "mkdir -p ${dataDir}")
      pulse
      pipewire
    ]
  );
in
{
  options.modules.media.netflix = {
    enable = lib.mkEnableOption "Enable ${name} desktop application through google chrome";
  };

  config.home.packages = lib.mkIf netflix.enable [ jailed ];
}
