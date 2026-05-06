{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.printing;
in
{
  options = {
    systemSettings.printing = {
      enable = lib.mkEnableOption "Enable printing";
    };
  };
  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
    environment.systemPackages = [ pkgs.cups-filters ];
  };
}
