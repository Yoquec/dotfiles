{
  lib,
  config,
  ...
}:
{
  options.modules.media.yt-dlp = {
    enable = lib.mkEnableOption "Enable yt-dlp";
    installBinary = lib.mkEnableOption "Install yt-dlp binary with nix";
  };

  config.modules.media.yt-dlp.installBinary = lib.mkDefault false;

  config.programs = lib.mkIf config.modules.media.yt-dlp.enable {
    yt-dlp.enable = config.modules.media.yt-dlp.installBinary;

    zsh.shellAliases = lib.mkIf config.modules.development.zsh.enable {
      yt = "yt-dlp --add-metadata -i";
      yta = "yt -x -f bestaudio/best";
    };
  };
}
