# https://wiki.nixos.org/wiki/PipeWire
{ lib, ... }:
{
  burrow.audio = {
    nixos = {
      security.rtkit.enable = true;

      # pipewire-pulse replaces the standalone PulseAudio daemon; running both
      # would have them fight over providing the PulseAudio service.
      services.pulseaudio.enable = lib.mkForce false;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          pulseaudio
          playerctl
          pulsemixer
        ];

        wayland.windowManager.sway.config.keybindings = {
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl play-pause";
          "XF86AudioStop" = "exec playerctl stop";
          "XF86AudioNext" = "exec playerctl next";
        };
      };
  };
}
