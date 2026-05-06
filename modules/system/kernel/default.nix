{
  config,
  lib,
  pkgs,
  ...
}:

# TODO: Replace KSPP settings with nix-mineral?
# https://github.com/cynicsketch/nix-mineral/tree/main

# INFO: Defines options for the installed kernel. Options are latest or lts.
# Also defines a kspp option to enable KSPP kernel hardening reccomendations

let
  kernel = config.systemSettings.kernel;
in
{
  options = {
    systemSettings.kernel = {
      # kspp = lib.mkEnableOption "Enable KSPP hardening";
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
    # boot.kernelParams = lib.mkIf kernel.kspp.enable [ ];
  };
}
