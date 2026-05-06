{ ... }:

{
  config = {
    userSettings = {
      terminal = "ghostty";
      browser = "brave";
      shells = [
        "zsh"
        "nushell"
      ];
      cli = "extra";
      langs = {
        node = {
          enable = true;
          nodemon.enable = true;
        };
        python.enable = true;
        rust.enable = true;
      };
      obsidian.enable = true;
    };
  };
}
