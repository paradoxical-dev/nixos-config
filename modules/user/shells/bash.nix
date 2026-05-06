{
  config,
  lib,
  ...
}:

let
  cfg = config.userSettings.bash.enable;
in
{
  options = {
    userSettings.bash = {
      enable = lib.mkEnableOption "Enable bash";
    };
  };
  config = lib.mkIf cfg {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = config.programs.zsh.shellAliases;
    };
  };
}
