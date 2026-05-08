{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Whether to include obsidian on the system.

let
  cfg = config.userSettings.obsidian;
in
{
  options = {
    userSettings.obsidian = {
      enable = lib.mkEnableOption "Enable Obsidian";
    };
  };
  config = lib.mkIf cfg.enable {
    # I typically don't manage obsidian with home-manager
    home.packages = with pkgs; [
      obsidian
      pandoc
    ];
  };
}
