{ config, pkgs, ... }:

{
  # Disable legacy PulseAudio, use PipeWire instead
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true; # Recommended session manager
  };

  # Real-time scheduling for audio
  security.rtkit.enable = true;
}
