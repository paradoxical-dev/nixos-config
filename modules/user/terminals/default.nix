{ config, lib, ... }:

# INFO: Defines the terminal to use for the system. The option value will be one
# of the list options below, returning the default if none is provided

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
