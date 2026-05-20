{ config, lib, pkgs, ... }:

# INFO: enable user level service of gpg

let
  cfg = config.userSettings.gpg;
in
{
  options = {
    userSettings.gpg = {
      enable = lib.mkEnableOption "Enable GPG agent";
      pinentry = lib.mkOption {
        default = "tty";
        description = "Pinentry interface to use";
        type = lib.types.enum ["gnome3" "curses" "qt" "tty" "all"];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.gpg-agent = {
      enable = true;
      pinentry.package = lib.mkMerge [
        (lib.mkIf (cfg.pinentry == "gnome3") pkgs.pinentry-gnome3)
        (lib.mkIf (cfg.pinentry == "curses") pkgs.pinentry-curses)
        (lib.mkIf (cfg.pinentry == "qt") pkgs.pinentry-qt)
        (lib.mkIf (cfg.pinentry == "tty") pkgs.pinentry-tty)
        (lib.mkIf (cfg.pinentry == "all") pkgs.pinentry-all)
      ];
      enableSshSupport = true;
      defaultCacheTtl = 3600;
      maxCacheTtl = 7200;
    };
  };
}
