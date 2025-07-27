# A module that automatically imports everything else in the current directory.
# See: https://github.com/juspay/nixos-unified-template/blob/main/modules/home/default.nix
{lib, ...}: {
  imports = with builtins;
    map
    (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  modules.zsh.enable = lib.mkDefault true;
  modules.fzf.enable = lib.mkDefault true;
  modules.direnv.enable = lib.mkDefault true;
  modules.nix.enable = lib.mkDefault false;
  modules.fontconfig.enable = lib.mkDefault true;
  modules.git.enable = lib.mkDefault true;
  modules.languageservers.enable = lib.mkDefault true;

  modules.lazygit = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };

  modules.yazi = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };

  modules.bat = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };

  modules.i3 = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };

  modules.tmux = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };

  modules.awscli = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };

  modules.yt-dlp = {
    enable = lib.mkDefault true;
    installBinary = lib.mkDefault false;
  };
}
