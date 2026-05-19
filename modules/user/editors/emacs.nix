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
      eaf = {
        enable = lib.mkEnableOption "Enable EAF";
        apps = lib.mkOption {
          default = with pkgs.emacsPackages; [ eaf-browser ];
          description = "EAF applications to enable";
          type = lib.types.listOf lib.types.package;
        };
      };
      extraPkgs = lib.mkOption {
        default = [];
        description = "Extra emacs packages to enable";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.mu.enable = lib.mkIf cfg.mail true;
    # handle emacs config outside of home-manager
    programs.emacs = {
      enable = true;
      package = if cfg.eaf.enable then pkgs.emacs-gtk else pkgs.emacs;
      extraPackages = (
        epkgs:
        with epkgs;
        [
          vterm
        ]
        ++ lib.optionals cfg.mail [ mu4e ]
        ++ lib.optionals cfg.eaf.enable [
          (eaf.withApplications cfg.eaf.apps)
        ]
      );
    };

    # eaf python deps
    userSettings.langs.python.enable = lib.mkIf cfg.eaf.enable true;
    userSettings.langs.python.extraPkgs = lib.optionals cfg.eaf.enable (
      with pkgs.python3Packages; [
        pyqt6
        pyqt6-sip
        pyqt6-webengine
        epc
        lxml
        sexpdata
        tld
        requests
        qrcode
        pysocks
        pymupdf
        pypinyin
        psutil
        retry
        markdown
      ]
    );

    # extra deps
    home.packages = with pkgs;
    [ ispell ]
    ++ lib.optionals cfg.eaf.enable [
      git
      nodejs
      wmctrl
      xdotool
      aria2
    ];

    # conditionally set QT env var for EAF.
    # See https://github.com/emacs-eaf/emacs-application-framework/wiki/NixOS
    home.sessionVariables = lib.mkIf cfg.eaf.enable {
      QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt6.qtbase.outPath}/lib/qt-6/plugins";
    };
  };
}
