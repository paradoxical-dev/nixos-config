{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.langs.R;
in
{
  options = {
    usersettings.langs.R = {
      enable = lib.mkEnableOption "Enable R with Rscript";
      extrapkgs = lib.mkOption {
        default = [  ];
        description = "Extra R packages to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages. = [ R ] ++ cfg.extraPkgs;
  };
}
