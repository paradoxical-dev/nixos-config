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
      extraPkgs = lib.mkOption {
        default = [ ];
        description = "Extra python packages to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        python3
      ]
      ++ cfg.extraPkgs;
  };
}
