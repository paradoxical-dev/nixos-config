{
  config,
  lib,
  inputs,
  ...
}:

let
  cfg = config.systemSettings.security.hardening;
in
{
  imports = [ inputs.nix-mineral.nixosModules.nix-mineral ];
  options = {
    systemSettings.security.hardening = {
      enable = lib.mkEnableOption "Enable hardening";
      preset = lib.mkOption {
        default = "compatibility";
        description = ''
          performance: disables or enables settings to aim at performance
          compatibility: disables or enables settings to aim at compatibility
          maximum: enables every optional security setting to have maximum protection
        '';
        type = lib.types.enum [
          "compatibility"
          "maximum"
          "performance"
        ];
      };
    };
  };
  config = lib.mkIf cfg.enable {
    nix-mineral.enable = true;
    nix-mineral.preset = cfg.preset;
  };
}
