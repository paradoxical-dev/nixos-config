{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.langs.rust;
in
{
  options = {
    userSettings.langs.rust = {
      enable = lib.mkEnableOption "Enable rust language";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rustc
      cargo
    ];
  };
}
