{
  config,
  lib,
  ...
}:

let
  cfg = config.userSettings.ghostty;
in
{
  options = {
    userSettings.ghostty = {
      enable = lib.mkEnableOption "Enable ghostty";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.ghostty.enable = true;
    programs.ghostty.systemd.enable = true;
    programs.ghostty.settings = {
      font-size = "13";
      font-family = "JetBrainsMono Nerd Font";
      font-family-italic = "Victor Mono";
      font-family-bold-italic = "Victor Mono";

      theme = "Nord";

      window-decoration = "none";
      window-padding-x = 5;
      window-padding-y = 5;
      window-padding-balance = true;
    };
  };
}
