{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

# INFO: Enables and configures the Niri compositor.
# Also enables and configures noctalia-shell

let
  cfg = config.userSettings.niri;
  noctalica-binary = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  noctalia-cmd =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);

  window-radius = 20.0;
  cursor-theme = "Bibata-Modern-Ice";
in
{
  imports = [
    inputs.noctalia.homeModules.default
    # inputs.niri.homeModules.config
  ];

  options = {
    userSettings.niri = {
      enable = lib.mkEnableOption "Enable Niri user config";
      noctalia.enable = lib.mkEnableOption "Enable noctalia shell";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.xwayland-satellite
      pkgs.nautilus
    ]
    ++ lib.optionals cfg.noctalia.enable [ noctalica-binary ];

    programs.noctalia-shell = lib.mkIf cfg.noctalia.enable {
      enable = true;
    };

    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = cursor-theme;
      size = 24;
      gtk.enable = true;
    };

    # programs.niri.enable = true;
    programs.niri.settings = {
      prefer-no-csd = true;
      environment = {
        NIXOS_OZONE_WL = "1";
        XCURSOR_THEME = cursor-theme;
        XCURSOR_SIZE = "24";
      };
      spawn-at-startup = lib.optionals cfg.noctalia.enable [
        {
          command = [
            "${noctalica-binary}/bin/noctalia-shell"
          ];
        }
      ];

      cursor = {
        theme = cursor-theme;
        size = 24;
      };

      window-rules = [
        {
          # rounded corners
          geometry-corner-radius = {
            top-left = window-radius;
            top-right = window-radius;
            bottom-left = window-radius;
            bottom-right = window-radius;
          };
          clip-to-geometry = true;
        }
      ];

      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };
      binds = with config.lib.niri.actions; {
        # apps
        "Mod+Return".action = spawn "${pkgs.ghostty}/bin/ghostty";
        # "Mod+Return".action.spawn = [
        #   "emacsclient"
        #   "-s"
        #   "vterm"
        #   "-c"
        #   "-e"
        #   "(my/new-frame-with-vterm)"
        # ];

        # workspace/window nav
        "Mod+O".action = toggle-overview;
        "Mod+Q".action = close-window;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+F".action = fullscreen-window;
        "Mod+V".action = toggle-window-floating;
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+Shift+1".action.move-window-to-workspace = 1;
        "Mod+Shift+2".action.move-window-to-workspace = 2;
        "Mod+Shift+3".action.move-window-to-workspace = 3;
        "Mod+Shift+4".action.move-window-to-workspace = 4;
        "Mod+Shift+5".action.move-window-to-workspace = 5;
        "Mod+Shift+E".action = quit;

        # column nav
        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+F".action = maximize-column;
        "Mod+Minus".action = set-column-width "-5%";
        "Mod+Equal".action = set-column-width "+5%";
        "Mod+0".action = set-column-width "80%";
        "Mod+Shift+Minus".action = set-window-height "-5%";
        "Mod+Shift+Equal".action = set-window-height "+5%";

        # noctalia
        "Mod+Space".action.spawn = noctalia-cmd "launcher toggle";
        "Mod+Escape".action.spawn = noctalia-cmd "lockScreen lock";
        "Mod+Comma".action.spawn = noctalia-cmd "settings toggle";
        "Mod+Shift+Space".action.spawn = noctalia-cmd "controlCenter toggle";
        "XF86AudioLowerVolume".action.spawn = noctalia-cmd "volume decrease";
        "XF86AudioRaiseVolume".action.spawn = noctalia-cmd "volume increase";
        "XF86AudioMute".action.spawn = noctalia-cmd "volume muteOutput";
        "XF86MonBrightnessUp".action.spawn = noctalia-cmd "brightness increase";
        "XF86MonBrightnessDown".action.spawn = noctalia-cmd "brightness decrease";
      };

      layout = {
        gaps = 12;

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 1.0; }
        ];
        default-column-width.proportion = 0.8;

        focus-ring.enable = false;
        border = {
          enable = false;
          # active.color = "#66666666"
        };
      };
    };
  };
}
