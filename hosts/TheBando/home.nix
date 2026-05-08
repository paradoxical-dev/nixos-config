{ ... }:

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
      gnome.enable = true;
      obsidian.enable = true;
      langs = {
        zeal.enable = true;
        node = {
          enable = true;
          nodemon.enable = true;
        };
        python.enable = true;
        rust.enable = true;
      };
    };
  };
}
