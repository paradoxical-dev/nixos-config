{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.zed;
in
{
  options = {
    userSettings.zed = {
      enable = lib.mkEnableOption "Enable Zed editor";
    };
  };
  config = lib.mkIf cfg.enable {
    # handle zed config outside of home-manager
    home.packages = with pkgs; [ zed-editor ];
    # programs.zed-editor = {
    #   enable = true;
    # };
  };
}
