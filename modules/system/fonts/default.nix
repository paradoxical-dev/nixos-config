{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Set the desired font(s) for the system

let
  cfg = config.systemSettings.fonts;
in
{
  options = {
    systemSettings.fonts = {
      std = lib.mkOption {
        default = [ pkgs.noto-fonts ];
        description = "Standard fonts to include on the system";
        type = lib.types.listOf lib.types.package;
      };
      nerd = lib.mkOption {
        default = [ ];
        description = "Nerd fonts to include on the system.";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = {
    fonts.packages = cfg.std ++ cfg.nerd;
  };
}
