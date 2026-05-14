{ config, lib, ... }:

let
  cfg = config.systemSettings.security.fail2ban;
in
{
  options = {
    systemSettings.security.fail2ban = {
      enable = lib.mkEnableOption "Enable fail2ban";
    };
  };
  config = lib.mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      jails = {
        sshd = {
          settings = {
            port = 22;
            filter = "sshd";
            maxRetry = 5;
            bantime = 86400; # 1 day
            findtime = 600;
          };
        };
      };
    };
  };
}
