{ config, lib, ... }:

let
  cfg = config.systemSettings.security.sshd;
in
{
  options = {
    systemSettings.security.sshd = {
      enable = lib.mkEnableOption "Enable incoming ssh connections";
    };
  };
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
