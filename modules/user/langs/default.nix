{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Language modules. Each module within this dir defines the langauges
# options and packages to be installed under userSettings.langs.<language>

let
  zeal-docs = config.userSettings.langs.zeal;
in
{
  options = {
    userSettings.langs.zeal = {
      enable = lib.mkEnableOption "Enable Zeal documentation app";
    };
  };
  config = lib.mkIf zeal-docs.enable {
    home.packages = with pkgs; [ zeal ];
  };
}
