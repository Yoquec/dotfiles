# https://wiki.nixos.org/wiki/Hardware/Framework/Laptop_13
{ inputs, burrow, ... }:
{
  den.aspects.framework = {
    includes = [
      burrow.wireless
      burrow.firmware
    ];
    nixos = {
      imports = [ inputs.nixos-hardware.nixosModules.framework-13-7040-amd ];
      boot.extraModprobeConfig = ''
        options cfg80211 ieee80211_regdom=ES
      '';
    };
  };
}
