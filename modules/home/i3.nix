{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.i3.enable = lib.mkEnableOption "Enable i3 and i3-blocks";
  options.modules.i3.installBinary = lib.mkEnableOption "Install i3 and i3-blocks through home-manager";

  config = lib.mkIf config.modules.i3.enable {
    # TODO: i3 should be installed through home-manager once NixOS is installed
    # TODO: Add wallpaper through overlay?

    home.file = {
      ".config/i3".source = ../../dotfiles/i3;
      ".config/i3blocks".source = ../../dotfiles/i3blocks;
    };

    home.packages = lib.mkIf config.modules.i3.installBinary (with pkgs; [
      i3
      i3blocks
      (
        pkgs.writeShellScriptBin "volume-i3blocks"
        (builtins.readFile ../../dotfiles/i3blocks/bin/volume-i3blocks)
      )
      (
        pkgs.writeShellScriptBin "battery-i3blocks"
        (builtins.readFile ../../dotfiles/i3blocks/bin/volume-i3blocks)
      )
    ]);
  };
}
