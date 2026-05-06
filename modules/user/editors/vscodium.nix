{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.vscodium;
in
{
  options = {
    userSettings.vscodium = {
      enable = lib.mkEnableOption "Enable VSCodium";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ vscodium-fhs ];
  };
}
