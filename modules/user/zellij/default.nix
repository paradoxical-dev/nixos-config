{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.userSettings.zellij;
in
{
  options = {
    userSettings.zellij = {
      enable = lib.mkEnableOption "Enable zellij multiplexer";
      plugins = lib.mkOption {
        default = [ ];
        description = "Plugins to install along side zellij";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ zellij ];
  };
}
