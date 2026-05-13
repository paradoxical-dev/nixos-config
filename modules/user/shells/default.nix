{
  config,
  lib,
  ...
}:

# INFO: Defines the shells available.
# Each submodule will contain that shells options.

let
  shells = config.userSettings.shells;
in
{
  options = {
    userSettings.shells = lib.mkOption {
      default = [ "zsh" ];
      description = "Shells to include";
      type = lib.types.listOf (
        lib.types.enum [
          "zsh"
          "bash"
          "nushell"
        ]
      );
    };
  };
  config = {
    userSettings.zsh.enable = lib.mkDefault (builtins.elem "zsh" shells);
    userSettings.bash.enable = lib.mkDefault (builtins.elem "bash" shells);
    userSettings.nushell.enable = lib.mkDefault (builtins.elem "nushell" shells);
  };
}
