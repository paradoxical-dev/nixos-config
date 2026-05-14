{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.langs.python;
in
{
  options = {
    userSettings.langs.python = {
      enable = lib.mkEnableOption "Enable python";
      lsp = {
        enable = lib.mkEnableOption "Enable python lsp";
        packages = lib.mkOption {
          default = [ pkgs.pyright ];
          description = "Python lsp package";
          type = lib.types.listOf lib.types.package;
        };
      };
      formatter = {
        enable = lib.mkEnableOption "Enable python formatter";
        packages = lib.mkOption {
          default = [ pkgs.ruff ];
          description = "Python formatter package(s)";
          type = lib.types.listOf lib.types.package;
        };
      };
      extraPkgs = lib.mkOption {
        default = [ ];
        description = "Extra python packages to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.python3.withPackages (_: cfg.extraPkgs))
    ]
    ++ lib.optionals cfg.lsp.enable cfg.lsp.packages
    ++ lib.optionals cfg.formatter.enable cfg.formatter.packages;
  };
}
