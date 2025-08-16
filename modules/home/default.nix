{lib, ...}: {
  imports = [
    ./fontconfig.nix
    ./i3.nix
    ./yt-dlp.nix
  ];

  modules.fontconfig.enable = true;

  modules.i3 = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };

  modules.yt-dlp = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };
}
