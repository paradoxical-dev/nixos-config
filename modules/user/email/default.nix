{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: sets some email configuration options. Also provides
# some clients in their respective submodules

let
  cfg = config.userSettings.email;
in
{
  options = {
    userSettings.email = {
      enable = lib.mkEnableOption "Enable email on the host";
      clients = lib.mkOption {
        default = null;
        description = "Email client to install on the system";
        type = lib.types.package;
      };
      maildirBase = lib.mkOption {
        default = "${config.home.homeDirectory}/Mail";
        description = "Base directory for maildirs";
        type = lib.types.str;
      };
      accounts = lib.mkOption {
        default = {};
        description = "Email accounts to configure";
        type = lib.types.attrsOf (lib.types.submodule {
          options = {
            address = lib.mkOption {
              type = lib.types.str;
              description = "Email address";
            };
            realName = lib.mkOption {
              type = lib.types.str;
              description = "Display name";
            };
            imap.host = lib.mkOption {
              type = lib.types.str;
              description = "IMAP server hostname";
            };
            smtp.host = lib.mkOption {
              type = lib.types.str;
              description = "SMTP server hostname";
            };
            primary = lib.mkOption {
              default = false;
              type = lib.types.bool;
              description = "Whether this is the primary account";
            };
            mbsync = {
              patterns = lib.mkOption {
                default = [ "*" ];
                description = "Mailbox patterns to sync.";
                type = lib.types.listOf lib.types.str;
              };
              expunge = lib.mkOption {
                default = "both";
                description = "When to expunge deleted messages";
                type = lib.types.enum [ "none" "both" "remote" "local" ];
              };
            };
          };
        });
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.mbsync.enable = true;
    programs.msmtp.enable = true;
    programs.mu.enable = true;
    home.packages = [ pkgs.pass ];

    accounts.email = {
      maildirBasePath = cfg.maildirBase;

      accounts = lib.mapAttrs (name: acc: {
        inherit (acc) address realName primary;

        userName = acc.address;

        imap.host = acc.imap.host;
        smtp.host = acc.smtp.host;
        smtp.tls.enable = true;
        imap.tls.enable = true;

        passwordCommand = "pass email/${name}";

        mbsync = {
          enable = true;
          create = "maildir";
          expunge = acc.mbsync.expunge;
          patterns = acc.mbsync.patterns;
        };

        msmtp.enable = true;
        mu.enable = true;
      }) cfg.accounts;
    };
  };
}
