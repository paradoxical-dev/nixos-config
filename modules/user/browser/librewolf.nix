{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.librewolf;
in
{
  options = {
    userSettings.librewolf = {
      enable = lib.mkEnableOption "Enable librewolf browser";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.librewolf.enable = true;
  };
}
