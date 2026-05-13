{
  config,
  lib,
  pkgs,
  ...
}:

# INFO: Package bundle for engineering work. Includes CAD,
# graphing and circuit simulation software

let
  cfg = config.userSettings.engineering;
in
{
  options = {
    userSettings.engineering = {
      enable = lib.mkEnableOption "Enable package bundle for engineering";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      freecad
      openscad
      graphviz
      kicad
      gnuplot
      octave
      ngspice
    ];

    # extend pythons package list rather than install standalone
    userSettings.langs.python.enable = true;
    userSettings.langs.python.extraPkgs = with pkgs.python3Packages; [
      numpy
      matplotlib
      scipy
    ];
  };
}
