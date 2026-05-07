{ config, lib, ... }:

# INFO: Enables local documentation for nixos and installed packages

let
  cfg = config.systemSettings.extra-documentation;
in
{
  options = {
    systemSettings.extra-documentation = {
      enable = lib.mkEnableOption "Enable extra documentation for NixOS and installed packages";
    };
  };
  config = lib.mkIf cfg.enable {
    documentation.doc.enable = true;
    documentation.dev.enable = true;
    documentation.nixos.enable = true;
  };
}
