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
      # ltspice
      ngspice
      python313Packages.numpy
      python313Packages.matplotlib
      python313Packages.scipy
    ];
  };
}
