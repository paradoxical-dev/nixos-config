# INFO: Although this is technically a cli, it is kept as a separate module
# due to the unofficial flake used to install it

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.userSettings.terminal-browser;
in
{
  options = {
    userSettings.terminal-browser = {
      enable = lib.mkEnableOption "Enable terminal-browser";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.llm-agents.packages.${pkgs.system}.terminal-browser
    ];
  };
}
