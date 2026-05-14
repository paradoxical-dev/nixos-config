{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.langs.lua;
in
{
  options = {
    userSettings.langs.lua = {
      enable = lib.mkEnableOption "Enable lua";
      lsp = {
        enable = lib.mkEnableOption "Enable lua lsp";
        packages = lib.mkOption {
          default = [ pkgs.lua-language-server ];
          description = "Lua lsp package";
          type = lib.types.listOf lib.types.package;
        };
      };
      formatter = {
        enable = lib.mkEnableOption "Enable lua formatter";
        packages = lib.mkOption {
          default = [ pkgs.stylua ];
          description = "Lua formatter package";
          type = lib.types.listOf lib.types.package;
        };
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        lua
      ]
      ++ lib.optionals cfg.lsp.enable cfg.lsp.packages
      ++ lib.optionals cfg.formatter.enable cfg.formatter.packages;
  };
}
