{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.userSettings.langs.node;
in
{
  options = {
    userSettings.langs.node = {
      enable = lib.mkEnableOption "Enable Node.js";
      nodemon.enable = lib.mkEnableOption "Enable nodemon system wide";
      extraPkgs = lib.mkOption {
        default = [ ];
        description = "Extra npm packages to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        nodejs
      ]
      ++ cfg.extraPkgs
      ++ lib.optionals cfg.nodemon.enable [
        nodemon
      ];
  };
}
