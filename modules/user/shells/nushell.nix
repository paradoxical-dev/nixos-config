{
  config,
  lib,
  ...
}:

let
  cfg = config.userSettings.nushell.enable;
in
{
  options = {
    userSettings.nushell = {
      enable = lib.mkEnableOption "Enable nushell";
    };
  };
  config = lib.mkIf cfg {
    programs.nushell = {
      enable = true;
    };
  };
}
