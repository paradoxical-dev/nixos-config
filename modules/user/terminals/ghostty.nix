{ config, lib, pkgs, ... }:

let
  cfg = config.userSettings.ghostty;
in
{
  options = {
    userSettings.ghostty = {
      enable = lib.mkEnableOption "Enable ghostty";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ghostty ];
    programs.ghostty.enable = true;
    programs.ghostty.systemd.enable = true;
    programs.ghostty.settings = {
      # TODO
    };
  };
}
