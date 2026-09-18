{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.hyprland;
  cursorTheme = "Bibata-Modern-Ice";
  hyprDots = "${config.userSettings.dotfilesDir}/modules/user/hyprland/conf";
in
{
  options = {
    userSettings.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = cursorTheme;
      size = 24;
      gtk.enable = true;
    };

    xdg.configFile."hypr/hyprland.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${hyprDots}/hyprland.lua";

    xdg.configFile."hypr/modules".source = config.lib.file.mkOutOfStoreSymlink "${hyprDots}/modules";
  };

}
