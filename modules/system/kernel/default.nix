{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Defines options for the installed kernel. Options are latest or lts.

let
  kernel = config.systemSettings.kernel;
in
{
  options = {
    systemSettings.kernel = {
      type = lib.mkOption {
        default = "latest";
        type = lib.types.enum [
          "latest"
          "lts"
        ];
      };
    };
  };
  config = {
    boot.kernelPackages = lib.mkMerge [
      (lib.mkIf (kernel.type == "latest") pkgs.linuxPackages_latest)
      (lib.mkIf (kernel.type == "lts") pkgs.linuxPackages)
    ];
  };
}
