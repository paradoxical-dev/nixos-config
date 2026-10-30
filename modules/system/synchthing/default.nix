{
  config,
  lib,
  ...
}:
let
  cfg = config.systemSettings.syncthing;
in
{
  options = {
    systemSettings.syncthing = {
      enable = lib.mkEnableOption "Enable syncthing service";
      dataDir = lib.mkOption {
        default = "/home";
        description = "Directories syncthing will have access to";
        type = lib.types.str;
      };
      user = lib.mkOption {
        default = "synchthing";
        description = "User to run synchthing as";
        type = lib.types.str;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = cfg.enable;
      user = cfg.user;
      dataDir = cfg.dataDir;
      openDefaultPorts = true;
    };
  };
}
