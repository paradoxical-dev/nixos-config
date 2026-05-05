{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.langs.python;
in
{
  options = {
    userSettings.langs.python = {
      enable = lib.mkEnableOption "Enable python";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      python3
    ];
  };
}
