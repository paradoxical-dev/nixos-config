{ config, lib, ... }:

let
  cfg = config.systemSettings.security.unbound;
in
{
  options = {
    systemSettings.security.unbound = {
      enable = lib.mkEnableOption "Enable unbound";
    };
  };
  config = lib.mkIf cfg.enable {
    services.unbound = {
      enable = true;
      settings = {
        server = {
          verbosity = 1;
          interface = [ "127.0.0.1" ];
          port = 53;
          do-ip4 = true;
          do-ip6 = false;
          do-tcp = true;
          access-control = [ "127.0.0.0/8 allow" ];
          cache-max-ttl = 86400; # 1 day
          cache-min-ttl = 3600; # 1 hour
        };
        forward-zone = [
          {
            name = ".";
            forward-tls-upstream = true;
            forward-addr = [
              "1.1.1.1@853"
              "9.9.9.9@853"
              # "8.8.8.8@853"
            ];
          }
        ];
      };
    };

    networking.resolvconf = {
      enable = true;
      useLocalResolver = true;
      dnsSingleRequest = true;
    };
  };
}
