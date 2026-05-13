{ pkgs, ... }:

{
  config = {
    userSettings = {
      dotfilesDir = "REPO PATH";
      terminal = "ghostty";
      shells = [ "zsh" ];
      starship.enable = true;
      cli = "base";
      editors = [ "neovim" ];
      browser = "firefox";
      langs = { };
    };
  };
}
