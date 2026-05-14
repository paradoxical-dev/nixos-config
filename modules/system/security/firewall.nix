{ config, lib, ... }:

let
  cfg = config.systemSettings.security.firewall;
in
{
  options = {
    systemSettings.security.firewall = {
      enable = lib.mkEnableOption "Enable firewall";
      allowSSH = lib.mkEnableOption "Allow SSH through firewall";
      extraTCPPorts = lib.mkOption {
        default = [ ];
        description = "Extra TCP ports to allow";
        type = lib.types.listOf lib.types.port;
      };
      extraUDPPorts = lib.mkOption {
        default = [ ];
        description = "Extra UDP ports to allow";
        type = lib.types.listOf lib.types.port;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = lib.optionals cfg.allowSSH [ 22 ] ++ cfg.extraTCPPorts;
      allowedUDPPorts = cfg.extraUDPPorts;
    };
  };
}
