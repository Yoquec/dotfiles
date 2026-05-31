{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config) xdg;
  inherit (config.modules.x11) i3;

  # Patch the i3 config file to add the correct wallpaper
  patched = pkgs.runCommand "i3-config-patched" { } ''
    cp -r ${../../../dotfiles/i3} $out
    chmod -R u+w $out
    substituteInPlace $out/config \
      --replace "wallpaper.png" "${../../../assets/wallpapers/charcoal_creation_of_adam.png}"
  '';
in
{
  options.modules.x11.i3 = {
    enable = lib.mkEnableOption "Enable i3 and i3-blocks";
    installBinary = lib.mkEnableOption "Install i3 and i3-blocks through home-manager";
  };

  config = lib.mkIf i3.enable {
    # TODO: i3 should be installed through home-manager once NixOS is installed

    home.file = {
      "${xdg.configHome}/i3".source = patched;
      "${xdg.configHome}/i3blocks".source = ../../../dotfiles/i3blocks;
    };

    home.packages = lib.mkIf i3.installBinary (
      with pkgs;
      [
        i3
        i3blocks
        (pkgs.writeShellScriptBin "volume-i3blocks" (
          builtins.readFile ../../dotfiles/i3blocks/bin/volume-i3blocks
        ))
        (pkgs.writeShellScriptBin "battery-i3blocks" (
          builtins.readFile ../../dotfiles/i3blocks/bin/volume-i3blocks
        ))
      ]
    );
  };
}
