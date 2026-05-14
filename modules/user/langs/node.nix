{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.userSettings.langs.node;
in
{
  options = {
    userSettings.langs.node = {
      enable = lib.mkEnableOption "Enable Node.js";
      nodemon.enable = lib.mkEnableOption "Enable nodemon system wide";
      lsp = {
        enable = lib.mkEnableOption "Enable JS lsp";
        packages = lib.mkOption {
          default = [
            pkgs.typescript
            pkgs.typescript-language-server
          ];
          description = "JS lsp package(s)";
          type = lib.types.listOf lib.types.package;
        };
      };
      formatter = {
        enable = lib.mkEnableOption "Enable node formatter";
        packages = lib.mkOption {
          default = [ pkgs.prettier ];
          description = "Node formatter package";
          type = lib.types.listOf lib.types.package;
        };
      };
      extraPkgs = lib.mkOption {
        default = [ ];
        description = "Extra npm packages to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        nodejs
      ]
      ++ lib.optionals cfg.lsp.enable cfg.lsp.packages
      ++ lib.optionals cfg.formatter.enable cfg.formatter.packages
      ++ cfg.extraPkgs
      ++ lib.optionals cfg.nodemon.enable [
        nodemon
      ];
  };
}
