{ config, lib, ... }:

# INFO: Describes the base options for cli tools to be installed.
# ---
# base:   base cli tools installed on *almost* every machine
# ectras: extra tools not necessary but nice to have

let
  cli = config.userSettings.cli;
in
{
  options = {
    userSettings.cli = lib.mkOption {
      default = null;
      description = "CLI tools";
      type = lib.types.enum [ "base" "extra" null ];
    };
  };
  config = {
    userSettings.cliBase.enable = lib.mkIf (cli == "base" || cli == "extra") true;
    userSettings.cliExtra.enable = lib.mkIf (cli == "extra") true;
  };
}
