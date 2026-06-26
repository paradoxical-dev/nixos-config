{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: sets up KDE plasma at system level
# Should be paired with respective user module for best experience

let
  cfg = config.systemSettings.kde;
in
{
  options = {
    systemSettings.kde = {
      enable = lib.mkEnableOption "Enable KDE Plasma";
    };
  };
  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    services.desktopManager.plasma6.enable = true;
    services.displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      kate
      ktexteditor
    ];
  };
}
