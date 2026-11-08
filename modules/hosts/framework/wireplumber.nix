# this host's onboard AMD audio card exposes a non-functional ALSA device
# that wireplumber otherwise tries (and fails) to use as a sink.
{ ... }:
{
  den.aspects.framework.nixos.services.pipewire.wireplumber.extraConfig."51-amd-disable" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          { "device.name" = "alsa_card.pci-0000_c1_00.1"; }
        ];
        actions.update-props."device.disabled" = true;
      }
    ];
  };
}
