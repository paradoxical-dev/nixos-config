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
      gnome.enable = true;
      obsidian.enable = true;
      langs = {
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
