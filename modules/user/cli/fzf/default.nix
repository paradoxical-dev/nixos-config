{
  config,
  lib,
  ...
}:

let
  cfg = config.userSettings.fzf;
in
{
  options = {
    userSettings.fzf = {
      enable = lib.mkEnableOption "Enable fzf";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultOptions = [
        "--height 40%"
        "--prompt "
      ];
      colors = {
        "fg+" = "#eceff4";
        "bg+" = "#434c5e";
        hl = "#80b3b2";
        "hl+" = "#9fc6c5";
        info = "#60728a";
        marker = "#b48ead";
        prompt = "#81a1c1";
        spinner = "#c5727a";
        pointer = "#d08770";
        header = "#a3be8c";
      };
    };
  };
}
