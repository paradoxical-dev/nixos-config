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
    userSettings.langs.R = {
      enable = lib.mkEnableOption "Enable R with Rscript";
      extraPkgs = lib.mkOption {
        default = [  ];
        description = "Extra R packages to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ R ] ++ cfg.extraPkgs;
  };
}
