{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.ghostty;
  ghosttyShaders = pkgs.fetchFromGitHub {
    owner = "sahaj-b";
    repo = "ghostty-cursor-shaders";
    rev = "main";
    hash = "sha256-G/UIr1bKnxn1AcHl/4FL/jou6b7M2VeREslYVELxdmw=";
  };
  themePath = "${config.userSettings.dotfilesDir}/modules/user/terminals/ghostty/themes";
in
{
  options = {
    userSettings.ghostty = {
      enable = lib.mkEnableOption "Enable ghostty";
    };
  };
  config = lib.mkIf cfg.enable {
    # copy over shaders
    home.file.".config/ghostty/shaders" = {
      source = ghosttyShaders;
      recursive = true;
    };

    programs.ghostty.enable = true;
    programs.ghostty.systemd.enable = true;
    programs.ghostty.settings = {
      font-size = "13";
      font-family = "JetBrainsMono Nerd Font";
      font-family-italic = "Victor Mono";
      font-family-bold-italic = "Victor Mono";

      theme = "${config.home.homeDirectory}/.config/ghostty/themes/current";
      custom-shader = "${config.home.homeDirectory}/.config/ghostty/shaders/cursor_warp.glsl";

      window-decoration = "none";
      window-padding-balance = true;
    };
  };
}
