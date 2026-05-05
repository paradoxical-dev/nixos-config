{ config, lib, pkgs, ... }:
let
  cfg = config.userSettings.cliExtra;
in
{
  options = {
    userSettings.cliExtra = {
      enable = lib.mkEnableOption "Enable extra CLI tools";
    };
  };
  config = lib.mkIf cfg.enable { };
}
