{ config, lib, pkgs, ... }:
let
  cfg = config.userSettings.langs.node;
in
{
  options = {
    userSettings.langs.node = {
      enable = lib.mkEnableOption "Enable Node.js";
      nodemon.enable = lib.mkEnableOption "Enable nodemon system wide";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs
    ] ++ lib.optionals cfg.nodemon.enable [
      nodemon
    ];
  };
}
