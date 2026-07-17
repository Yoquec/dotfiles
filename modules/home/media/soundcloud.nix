{
  lib,
  jail,
  config,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
  inherit (config.modules.media) soundcloud;

  name = "soundcloud";
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
  options.modules.media.soundcloud = {
    enable = lib.mkEnableOption "Enable ${name} desktop application through google chrome";
  };

  config.home.packages = lib.mkIf soundcloud.enable [ jailed ];
}
