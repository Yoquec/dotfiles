{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.i3.enable = lib.mkEnableOption "Enable i3 and i3-blocks";
  options.modules.i3.install = lib.mkEnableOption "Install i3 and i3-blocks through home-manager";

  config = lib.mkIf config.modules.i3.enable {
    home.file = {
      # TODO: i3 should be installed through home-manager once NixOS is installed
      # TODO: Add wallpaper thorugh overlay
      ".config/i3".source = ../../dotfiles/i3;
      ".config/i3blocks".source = ../../dotfiles/i3blocks;
      ".local/bin/volume-i3blocks" = {
        executable = true;
        source = ../../dotfiles/i3blocks/bin/volume-i3blocks;
      };
    };

    home.packages = lib.mkIf config.modules.i3.install (with pkgs; [
      i3
      i3blocks
    ]);
  };
}
