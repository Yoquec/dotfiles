{ ... }: {
  burrow.firmware.nixos = {
    hardware.enableRedistributableFirmware = true;
  };
}
