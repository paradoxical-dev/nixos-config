{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: A bundle of packages used for research and paper writing

let
  cfg = config.userSettings.research;
in
{
  options = {
    userSettings.research = {
      enable = lib.mkEnableOption "Enable research pacakages";
      texlivePackages = lib.mkOption {
        default = [ pkgs.texliveSmall ];
        description = "texlive package to include";
        type = lib.types.listOf lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        pandoc
        zotero
      ]
      ++ cfg.texlivePackages;
  };
}
