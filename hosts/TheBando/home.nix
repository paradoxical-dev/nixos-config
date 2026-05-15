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
      obsidian.enable = true;
      webull.enable = true;
      gnome.enable = true;
      langs = {
        zeal.enable = true;
        node = {
          enable = true;
          nodemon.enable = true;
          lsp.enable = true;
          formatter.enable = true;
        };
        python = {
          enable = true;
          lsp.enable = true;
          formatter.enable = true;
          debugger.enable = true;
          extraPkgs = with pkgs.python3Packages; [
            pandas
            pytest
          ];
        };
        rust = {
          enable = true;
          lsp.enable = true;
          formatter.enable = true;
        };
        lua = {
          enable = true;
          lsp.enable = true;
          formatter.enable = true;
        };
      };
    };
  };
}
