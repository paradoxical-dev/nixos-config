{ ... }:

{
  config = {
    userSettings = {
      terminal = "ghostty";
      shells = [
        "zsh"
        "nushell"
      ];
      cli = "extra";
      browser = "brave";
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
