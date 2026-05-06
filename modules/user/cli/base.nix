{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.cliBase;
in
{
  options = {
    userSettings.cliBase = {
      enable = lib.mkEnableOption "Enable base CLI tools";
    };
  };
  config = lib.mkIf cfg.enable {
    userSettings.tmux.enable = true;
    userSettings.fzf.enable = true;
    home.packages = with pkgs; [
      bat
      bottom
      brightnessctl
      eza
      fd
      file
      hwinfo
      jiq
      jq
      lazygit
      libnotify
      ripgrep
      ripgrep-all
      rsync
      smartmontools
      tealdeer
      unzip
      zip
    ];
  };
}
