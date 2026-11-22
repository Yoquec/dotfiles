# https://wiki.nixos.org/wiki/Wpa_supplicant
# https://wiki.nixos.org/wiki/Steam_Frame
{ burrow, ... }:
{
  burrow.wireless = {
    includes = [ burrow.firmware ];

    nixos = {
      hardware.wirelessRegulatoryDatabase = true;
    };
  };
}
