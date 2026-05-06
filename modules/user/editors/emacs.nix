{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.emacs;
in
{
  options = {
    userSettings.emacs = {
      enable = lib.mkEnableOption "Enable Emacs";
    };
  };
  config = lib.mkIf cfg.enable {
    # handle emacs config outside of home-manager
    home.packages = with pkgs; [ emacs ];
    # programs.emacs = {
    #   enable = true;
    # };
  };
}
