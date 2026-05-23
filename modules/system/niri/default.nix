{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

# INFO: sets up the system level of niri.
# Should also be paired with the respective user module

let
  cfg = config.systemSettings.niri;
in
{
  imports = [ inputs.niri.nixosModules.niri ];

  options = {
    systemSettings.niri = {
      enable = lib.mkEnableOption "Enable Niri compositor";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    programs.niri.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    environment.systemPackages =  with pkgs; [
      bibata-cursors
      # papirus-icon-theme
    ];
  };
}
