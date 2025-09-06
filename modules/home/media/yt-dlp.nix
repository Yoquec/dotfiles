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

  config = lib.mkIf config.modules.media.yt-dlp.enable {
    programs.yt-dlp.enable = config.modules.media.yt-dlp.installBinary;

    programs.zsh.shellAliases = lib.mkIf config.modules.development.zsh.enable {
      yt = "yt-dlp --add-metadata -i";
      yta = "yt -x -f bestaudio/best";
    };
  };
}
