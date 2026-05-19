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
      mail = lib.mkEnableOption "Enable mail";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.mu.enable = lib.mkIf cfg.mail true;
    # handle emacs config outside of home-manager
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = (
        epkgs:
        with epkgs;
        [
          vterm
        ]
        ++ lib.optionals cfg.mail [ mu4e ]
      );
    };
    # extra deps
    home.packages = with pkgs; [ ispell ];
  };
}
