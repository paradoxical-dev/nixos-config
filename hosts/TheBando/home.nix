{ ... }:

{
  config = {
    userSettings = {
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
