{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Handles the dconf settings for the GNOME DE

let
  cfg = config.userSettings.gnome;
in
{
  options = {
    userSettings.gnome = {
      enable = lib.mkEnableOption "Enable GNOME dconf via home-manager";
    };
  };
  config = lib.mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "teal";
          color-scheme = "prefer-dark";
          enable-animations = true;
          show-battery-percentage = false;
        };
        "org/gnome/desktop/peripherals/mouse" = {
          natural-scroll = true;
        };
        # TODO: needs updated with new binds
        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
          move-to-workspace-1 = [ "<Super><Shift>1" ];
          move-to-workspace-10 = [ "<Super><Shift>0" ];
          move-to-workspace-2 = [ "<Super><Shift>2" ];
          move-to-workspace-3 = [ "<Super><Shift>3" ];
          move-to-workspace-4 = [ "<Super><Shift>4" ];
          move-to-workspace-5 = [ "<Super><Shift>5" ];
          move-to-workspace-6 = [ "<Super><Shift>6" ];
          move-to-workspace-7 = [ "<Super><Shift>7" ];
          move-to-workspace-8 = [ "<Super><Shift>8" ];
          move-to-workspace-9 = [ "<Super><Shift>9" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          toggle-fullscreen = [ "<Super>f" ];
        };
        "org/gnome/desktop/wm/preferences" = {
          auto-raise = true;
          button-layout = "appmenu:minimize,maximize,close";
          focus-mode = "sloppy";
          num-workspaces = 10;
          workspace-names = [
            "Home"
            "Web"
            "Dev"
            "Notes"
          ];
        };
        "org/gnome/shell" = {
          enabled-extensions = [
            pkgs.gnomeExtensions.open-bar.extensionUuid
            pkgs.gnomeExtensions.vitals.extensionUuid
            pkgs.gnomeExtensions.blur-my-shell.extensionUuid
            pkgs.gnomeExtensions.just-perfection.extensionUuid
            pkgs.gnomeExtensions.dash2dock-lite.extensionUuid
            pkgs.gnomeExtensions.tiling-shell.extensionUuid
            pkgs.gnomeExtensions.space-bar.extensionUuid
            pkgs.gnomeExtensions.gnome-40-ui-improvements.extensionUuid
          ];
        };

        # EXTENSIONS #

        # blue-my-shell
        "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
          brightness = 0.59999999999999998;
          sigma = 30;
        };
        "org/gnome/shell/extensions/blur-my-shell/applications" = {
          blacklist = [
            "Plank"
            "com.desktop.ding"
            "Conky"
            "brave-browser"
          ];
          blur = true;
          brightness = 0.59999999999999998;
          dynamic-opacity = false;
          enable-all = true;
          opacity = 220;
          sigma = 50;
        };
        "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
          pipeline = "pipeline_default";
        };
        "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
          blur = true;
          brightness = 0.59999999999999998;
          pipeline = "pipeline_default_rounded";
          sigma = 30;
          static-blur = true;
          style-dash-to-dock = 0;
        };
        "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
          pipeline = "pipeline_default_rounded";
        };
        "org/gnome/shell/extensions/blur-my-shell/overview" = {
          pipeline = "pipeline_default_rounded";
        };
        "org/gnome/shell/extensions/blur-my-shell/panel" = {
          blur = false;
          brightness = 0.59999999999999998;
          pipeline = "pipeline_default";
          sigma = 30;
        };
        "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
          brightness = 0.59999999999999998;
          sigma = 30;
        };

        # dash2dock-lite
        "org/gnome/shell/extensions/dash2dock-lite" = {
          animation-bounce = 0.75;
          animation-magnify = 0.20000000000000001;
          animation-rise = 0.58999999999999997;
          animation-spread = 0.89000000000000001;
          apps-icon = false;
          autohide-dash = true;
          autohide-speed = 0.69999999999999996;
          blur-resolution = 0;
          border-radius = 2.5968586387434556;
          customize-label = false;
          dock-padding = 0.74672489082969429;
          downloads-icon = false;
          edge-distance = 0.67441860465116288;
          favorites-only = false;
          icon-border-radius = 3.0;
          icon-effect = 0;
          icon-size = 0.21551724137931033;
          icon-spacing = 0.83690987124463523;
          items-pullout-angle = 0.5;
          mounted-icon = false;
          msg-to-ext = "";
          multi-monitor-preference = 1;
          notification-badge-style = 0;
          open-app-animation = true;
          preferred-monitor = 0;
          pressure-sense = true;
          pressure-sense-sensitivity = 0.40000000000000002;
          running-indicator-size = 0;
          running-indicator-style = 2;
          scroll-sensitivity = 0.40000000000000002;
          shrink-icons = true;
          trash-icon = true;
        };

        # just-perfection
        "org/gnome/shell/extensions/just-perfection" = {
          support-notifier-showed-version = 36;
          workspace = true;
          workspace-popup = false;
          workspace-switcher-size = 0;
        };

        # open-bar
        "org/gnome/shell/extensions/openbar" = {
          balpha = 0.0;
          bartype = "Floating";
          bg-change = true;
          bgalpha = 0.80000000000000004;
          boxalpha = 0.0;
          bradius = 40.0;
          bwidth = 3.0;
          default-font = "Sans 12";
          margin = 7.0999999999999996;
          mbalpha = 0.0;
          mbgalpha = 0.90000000000000002;
          menustyle = false;
          neon = false;
          pause-reload = false;
          radius-bottomleft = true;
          radius-bottomright = true;
          radius-topleft = true;
          radius-topright = true;
          reloadstyle = true;
          set-notif-position = true;
          trigger-reload = false;
          width-top = true;
        };

        # space-bar
        "org/gnome/shell/extensions/space-bar/appearance" = {
          application-styles = ".space-bar {\n  -natural-hpadding: 12px;\n}\n\n.space-bar-workspace-label.active {\n  margin: 0 8px;\n  background-color: rgba(255,255,255,0.3);\n  color: rgba(255,255,255,1);\n  border-color: rgba(0,0,0,0);\n  font-weight: 700;\n  border-radius: 4px;\n  border-width: 0px;\n  padding: 3px 8px;\n}\n\n.space-bar-workspace-label.inactive {\n  margin: 0 8px;\n  background-color: rgba(0,0,0,0);\n  color: rgba(255,255,255,1);\n  border-color: rgba(0,0,0,0);\n  font-weight: 700;\n  border-radius: 4px;\n  border-width: 0px;\n  padding: 3px 8px;\n}\n\n.space-bar-workspace-label.inactive.empty {\n  margin: 0 8px;\n  background-color: rgba(0,0,0,0);\n  color: rgba(255,255,255,0.5);\n  border-color: rgba(0,0,0,0);\n  font-weight: 700;\n  border-radius: 4px;\n  border-width: 0px;\n  padding: 3px 8px;\n}";
          workspace-margin = 8;
          workspaces-bar-padding = 12;
        };
        "org/gnome/shell/extensions/space-bar/behavior" = {
          show-empty-workspaces = false;
          smart-workspace-names = false;
        };
        "org/gnome/shell/extensions/space-bar/shortcuts" = {
          enable-move-to-workspace-shortcuts = true;
        };

        # tiling-shell
        "org/gnome/shell/extensions/tilingshell" = {
          edge-tiling-mode = "default";
          enable-blur-snap-assistant = true;
          show-indicator = false;
          window-use-custom-border-color = false;
        };
      };
    };
  };
}
