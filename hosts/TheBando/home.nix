{ pkgs, ... }:

{
  config = {
    userSettings = {
      dotfilesDir = "/home/gitmoney/.dotfiles";
      terminal = "ghostty";
      shells = [
        "zsh"
        "nushell"
      ];
      starship.enable = true;
      cli = "extra";
      editors = [
        "neovim"
        "vscodium"
      ];
      browser = "brave";
      engineering.enable = true;
      research = {
        enable = true;
        texlivePackages = [ pkgs.texliveSmall ];
      };
      gnome.enable = true;
      obsidian.enable = true;
      langs = {
        zeal.enable = true;
        node = {
          enable = true;
          nodemon.enable = true;
        };
        python = {
          enable = true;
          extraPkgs = with pkgs.python313Packages; [
            pandas
          ];
        };
        rust.enable = true;
      };
    };
  };
}
