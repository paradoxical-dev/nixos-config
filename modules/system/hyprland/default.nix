{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.hyprland;
in
{
  options = {
    systemSettings.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland Desktop";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      config.common.default = [ "hyprland" ];
    };

    security.polkit.enable = true;

    services.gnome.gnome-keyring.enable = true;

    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard
      cliphist
      grim
      slurp
      polkit_gnome
      playerctl
      brightnessctl
      pavucontrol
    ];
  };
}
