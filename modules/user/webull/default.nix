{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Adds the Webull desktop application

let
  cfg = config.userSettings.webull;
in
{
  options = {
    userSettings.webull = {
      enable = lib.mkEnableOption "Enable Webull";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ webull-desktop ];
  };
}
