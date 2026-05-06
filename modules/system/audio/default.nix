{
  config,
  lib,
  ...
}:

# INFO: Audio settings. Enabled by default, only needs to be disabled
# if not needed on certain machine

let
  cfg = config.systemSettings.audio;
in
{
  options = {
    systemSettings.audio = {
      enable = lib.mkOption {
        default = true;
        description = "Enable audio";
        type = lib.types.bool;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
