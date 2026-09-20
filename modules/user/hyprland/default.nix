{
  config,
  lib,
  pkgs,
  inputs,
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
      dms.enable = lib.mkEnableOption "Enable the Dank Material shell";
    };
  };

  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = cursorTheme;
      size = 24;
      gtk.enable = true;
    };

    programs.dank-material-shell = lib.mkIf cfg.dms.enable {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      plugins = { };
    };
    # services.dms.enable = cfg.dms.enable;

    xdg.configFile."hypr/hyprland.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${hyprDots}/hyprland.lua";

    xdg.configFile."hypr/modules".source = config.lib.file.mkOutOfStoreSymlink "${hyprDots}/modules";
  };

}
