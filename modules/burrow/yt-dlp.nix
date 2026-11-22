# https://github.com/yt-dlp/yt-dlp
{ ... }:
{
  burrow.yt-dlp.homeManager = {
    programs.yt-dlp.enable = true;

    home.shellAliases = {
      yt = "yt-dlp --add-metadata -i";
      yta = "yt -x -f bestaudio/best";
    };
  };
}
