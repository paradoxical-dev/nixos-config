{ config, lib, ... }:
{
  options = {
    userSettings.terminal = lib.mkOption {
      default = "ghostty";
      description = "Default terminal";
      type = lib.types.enum [ "ghostty" "kitty" ];
    };
  };

  config = {
    userSettings.ghostty.enable = lib.mkDefault (config.userSettings.terminal == "ghostty");
    userSettings.kitty.enable = lib.mkDefault (config.userSettings.terminal == "kitty");
  };
}
