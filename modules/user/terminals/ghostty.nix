{
  config,
  lib,
  ...
}:

let
  cfg = config.userSettings.ghostty;
  themePath = "${config.userSettings.dotfilesDir}/modules/user/terminals/ghostty/themes";
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

      theme = "${config.home.homeDirectory}/.config/ghostty/themes/current";

      window-decoration = "none";
      window-padding-balance = true;
    };
  };
}
