{ config, lib, pkgs, ... }:

let
  cfg = config.userSettings.kitty;
in
{
  options = {
    userSettings.kitty = {
      enable = lib.mkEnableOption "Enable kitty";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.kitty ];
    programs.kitty.enable = true;
    programs.kitty.settings = {
      # TODO
    };
    programs.kitty.keybindings = {
      # TODO
    };
  };
}
