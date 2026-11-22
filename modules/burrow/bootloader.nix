# https://wiki.nixos.org/wiki/Systemd-boot
{ lib, ... }:
{
  burrow.bootloader.nixos = {
    boot.loader.systemd-boot.enable = lib.mkDefault true;
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
  };
}
