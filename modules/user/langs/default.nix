{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Language modules. Each module within this dir defines the langauges
# options and packages to be installed under userSettings.langs.<language>

let
  zeal-docs = config.userSettings.langs.zeal.enable;
  direnv-enabled = config.userSettings.langs.direnv.enable;
in
{
  options = {
    userSettings.langs.zeal = {
      enable = lib.mkEnableOption "Enable Zeal documentation app";
    };
    userSettings.langs.direnv = {
      enable = lib.mkEnableOption "Enable direnv";
    };
  };
  config = {
    home.packages = lib.optionals zeal-docs [ pkgs.zeal ];
    programs.direnv.enable = lib.mkIf direnv-enabled true;
  };
}
