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
        "emacs"
      ];
      emacs.mail = true;
      # emacs.eaf.enable = true;

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
        python = {
          # we keep python for quick scripts
          enable = true;
          lsp.enable = true;
          formatter.enable = true;
          debugger.enable = true;
          extraPkgs = with pkgs.python3Packages; [
            pandas
            pytest
            ipykernel
            metakernel
            jupyter
            notebook
          ];
        };
        lua = {
          # lua enabled for neovim config dev
          enable = true;
          lsp.enable = true;
          formatter.enable = true;
        };
      };
    };
  };
}
