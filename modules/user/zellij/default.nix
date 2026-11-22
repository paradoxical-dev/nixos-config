{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.userSettings.zellij;
in
{
  options = {
    userSettings.zellij = {
      enable = lib.mkEnableOption "Enable zellij multiplexer";
      plugins = lib.mkOption {
        default = { };
        description = "Plugins to install alongside zellij";
        type = lib.types.attrsOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    # home.packages = with pkgs; [ zellij ] ++ cfg.plugins;
    home.packages = with pkgs; [ zellij ];

    home.file = lib.mapAttrs' (
      name: plugin:
      lib.nameValuePair ".config/zellij/plugins/${name}.wasm" {
        source = plugin;
      }
    ) cfg.plugins;
  };
}
