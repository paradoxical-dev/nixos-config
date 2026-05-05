{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.firefox;
in
{
  options = {
    userSettings.firefox = {
      enable = lib.mkEnableOption "Enable firefox browser";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
