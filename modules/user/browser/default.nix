{
  config,
  lib,
  ...
}:

# INFO: Option to select browser based on the list available.

let
  browser = config.userSettings.browser;
in
{
  options = {
    userSettings.browser = lib.mkOption {
      default = null;
      description = "Default browser";
      type = lib.types.enum [
        "firefox"
        "librewolf"
        "brave"
        null
      ];
    };
  };

  config = {
    userSettings.firefox.enable = lib.mkIf (browser == "firefox") true;
    userSettings.librewolf.enable = lib.mkIf (browser == "librewolf") true;
    userSettings.brave.enable = lib.mkIf (browser == "brave") true;
  };
}
