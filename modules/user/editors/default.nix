{ config, lib, ... }:

# INFO: Editors to choose from. Each one will have its configuration
# handled by its respective submodule

let
  editors = config.userSettings.editors;
in
{
  options = {
    userSettings.editors = lib.mkOption {
      default = [ "neovim" ];
      description = "Editors to include on the system";
      type = lib.types.listOf (
        lib.types.enum [
          "neovim"
          "emacs"
          "vscodium"
          "zed"
        ]
      );
    };
  };
  config = {
    userSettings.neovim.enable = lib.mkDefault (builtins.elem "neovim" editors);
    userSettings.emacs.enable = lib.mkDefault (builtins.elem "emacs" editors);
    userSettings.vscodium.enable = lib.mkDefault (builtins.elem "vscodium" editors);
    userSettings.zed.enable = lib.mkDefault (builtins.elem "zed" editors);
  };
}
