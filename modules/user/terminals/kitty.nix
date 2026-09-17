{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.kitty;
in
{
  options = {
    userSettings.kitty = {
      enable = lib.mkEnableOption "Enable kitty";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.kitty ];
    programs.kitty.enable = true;
    programs.kitty.settings = {
      cursor_shape = "block";
      tab_title_max_length = 50;
      tab_title_template = "{tab.active_oldest_wd}";
      window_border_width = 1;

      window_padding_width = "5 15";

      enabled_layouts = "Grid, Stack";

      cursor_trail = 3;

      font_size = 14;
      font_family = "JetBrainsMono Nerd Font Mono";
      italic_font = "Victor Mono Italic";
      bold_italic_font = "Victor Mono Bold Italic";
    };
    programs.kitty.keybindings = {
      "ctrl+shift+;" = "next_layout";
      "ctrl+shift+h" = "previous_tab";
      "ctrl+shift+l" = "next_tab";
    };
    programs.kitty.extraConfig = ''
      include ${config.home.homeDirectory}/.config/kitty/themes/current.conf
    '';
  };
}
