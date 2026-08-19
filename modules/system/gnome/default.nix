{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Enables GNOME + GDM and defines base extensions. Also installs
# other ui packages like cursors, icons etc.

# NOTE: There is also the corresponding `user/gnome` module. This module will
# take care of dconf settings and extension enabling/disabling

let
  cfg = config.systemSettings.gnome;
in
{
  options = {
    systemSettings.gnome = {
      enable = lib.mkEnableOption "Enable GNOME Desktop";
    };
  };
  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    # services.displayManager.gdm.wayland = true;
    services.desktopManager.gnome.enable = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # use wayland > xwayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # enable keyring
    services.gnome.gnome-keyring.enable = true;

    # remove bloat
    environment.gnome.excludePackages = with pkgs; [
      epiphany
      evince
      geary
      gedit
      gnome-music
      gnome-terminal
      gnome-tour
      totem
    ];

    # extensions / extras
    environment.systemPackages = with pkgs; [
      papirus-icon-theme
      orchis-theme
      bibata-cursors
      gnome-tweaks
      gnomeExtensions.user-themes
      gnomeExtensions.open-bar
      gnomeExtensions.vitals
      gnomeExtensions.blur-my-shell
      gnomeExtensions.just-perfection
      gnomeExtensions.dash2dock-lite
      gnomeExtensions.tiling-shell
      gnomeExtensions.space-bar
      gnomeExtensions.gnome-40-ui-improvements
    ];
  };
}
