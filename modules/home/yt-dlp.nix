{
  lib,
  config,
  ...
}: {
  options.modules.yt-dlp = {
    enable = lib.mkEnableOption "Enable yt-dlp";
    installBinary = lib.mkEnableOption "Install yt-dlp binary with nix";
  };

  config = lib.mkIf config.modules.yt-dlp.enable {
    programs.yt-dlp.enable = config.modules.yt-dlp.installBinary;

    programs.zsh.shellAliases = lib.mkIf config.modules.zsh.enable {
      yt = "yt-dlp --add-metadata -i";
      yta = "yt -x -f bestaudio/best";
    };
  };
}
