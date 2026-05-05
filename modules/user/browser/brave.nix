{ config, lib, pkgs, ... }:

let
  cfg = config.userSettings.brave;
in
{
  options = {
    userSettings.brave = {
      enable = lib.mkEnableOption "Enable brave browser";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.brave.enable = true;
  };
}
