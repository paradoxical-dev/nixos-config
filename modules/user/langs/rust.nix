{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.langs.rust;
in
{
  options = {
    userSettings.langs.rust = {
      enable = lib.mkEnableOption "Enable rust language";
      lsp = {
        enable = lib.mkEnableOption "Enable rust lsp";
        packages = lib.mkOption {
          default = [ pkgs.rust-analyzer ];
          description = "Rust lsp package";
          type = lib.types.listOf lib.types.package;
        };
      };
      formatter = {
        enable = lib.mkEnableOption "Enable rust formatter";
        packages = lib.mkOption {
          default = [ pkgs.rustfmt ];
          description = "Rust formatter package";
          type = lib.types.listOf lib.types.package;
        };
      };
      extraPkgs = lib.mkOption {
        default = [ ];
        description = "Extra rust packages to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        rustc
        cargo
      ]
      ++ lib.optionals cfg.lsp.enable cfg.lsp.packages
      ++ lib.optionals cfg.formatter.enable cfg.formatter.packages
      ++ cfg.extraPkgs;
  };
}
