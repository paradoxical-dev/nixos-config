{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.tmux;
in
{
  options = {
    userSettings.tmux = {
      enable = lib.mkEnableOption "Enable tmux";
    };
  };
  config = lib.mkIf cfg.enable {
    # programs.tmux = {
    #     enable = true;
    # };
  };
}
