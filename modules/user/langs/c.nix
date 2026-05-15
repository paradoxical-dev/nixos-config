{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.langs.c;
in
{
  options = {
    userSettings.langs.c = {
      enable = lib.mkEnableOption "Enable c";
      lsp = {
        enable = lib.mkEnableOption "Enable c lsp";
        packages = lib.mkOption {
          default = [ pkgs.clang-tools ];
          description = "C lsp package(s)";
          type = lib.types.listOf lib.types.package;
        };
      };
      compiler = lib.mkOption {
        default = [ pkgs.gcc ];
        description = "C compiler";
        type = lib.types.listOf lib.types.package;
      };
      extraPkgs = lib.mkOption {
        default = [ ];
        description = "C extra package(s)";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages =
      [ ] ++ cfg.compiler ++ cfg.extraPkgs ++ lib.optionals cfg.lsp.enable cfg.lsp.packages;
  };
}
