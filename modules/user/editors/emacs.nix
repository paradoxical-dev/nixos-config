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
      daemon = lib.mkEnableOption "Enable Emacs daemon service";
      eaf = {
        enable = lib.mkEnableOption "Enable EAF";
        apps = lib.mkOption {
          default = with pkgs.emacsPackages; [ eaf-browser ];
          description = "EAF applications to enable";
          type = lib.types.listOf lib.types.package;
        };
      };
      package = lib.mkOption {
        default = pkgs.emacs;
        description = "The emacs package to install";
        type = lib.types.package;
      };
      extraPkgs = lib.mkOption {
        default = [ ];
        description = "Extra emacs packages to enable";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    # INFO: handle emacs config outside of home-manager
    programs.emacs = {
      enable = true;
      package = if cfg.eaf.enable then pkgs.emacs-gtk else cfg.package;
      # package = pkgs.emacs; # TODO: make option?
      extraPackages = (
        epkgs:
        with epkgs;
        [
          vterm # TODO: move to option?
          pdf-tools # TODO: move to option?
          treesit-grammars.with-all-grammars
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
      with pkgs.python3Packages;
      [
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
    home.packages =
      with pkgs;
      [
        # spell checking / dictionary
        ispell
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        wordnet

        # org mode
        sqlite
        graphviz

        # images
        imagemagick
        ghostscript
        vips

        # window management
        wmctrl

        # shell packages
        # TODO: move to langs module?
        shellcheck
        shfmt
      ]
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

    services.emacs = lib.mkIf cfg.daemon {
      enable = true;
      package = config.programs.emacs.finalPackage;
      client.enable = true;
      startWithUserSession = true;
    };
  };
}
