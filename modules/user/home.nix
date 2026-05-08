{ lib, ... }:

# INFO: Defines some base userSettings options

{
  options = {
    userSettings.dotfilesDir = lib.mkOption {
      default = "/etc/nixos";
      description = "Absolute path to the dotfiles directory";
      type = lib.types.path;
    };
  };
  config = { };
}
