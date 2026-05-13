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
      extraPkgs = lib.mkOption {
        default = [ ];
        description = "Extra rust packages to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rustc
      cargo
    ];
  };
}
