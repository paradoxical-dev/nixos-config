{ pkgs, ... }:

{
  config = {
    userSettings = {
      dotfilesDir = "/home/gitmoney/.dotfiles";

      gpg.enable = true;
      gpg.pinentry = "all";

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
      # emacs.daemon = true;
      # emacs.eaf.enable = true;

      browser = "brave";

      email = {
        enable = true;
        accounts = {
          personal = {
            address = "jaredonnell21@gmail.com";
            realName = "Jared Donnell";
            imap.host = "imap.gmail.com";
            smtp.host = "smtp.gmail.com";
            primary = true;
            mbsync.patterns = [
              "INBOX"
              "[Gmail]/Sent Mail"
              "[Gmail]/Drafts"
              "[Gmail]/Trash"
            ];
          };
        };
      };

      engineering.enable = true;
      research = {
        enable = true;
        texlivePackages = [ pkgs.texliveMedium ];
      };
      obsidian.enable = true;
      webull.enable = true;

      gnome.enable = true;
      # niri.enable = true;
      # niri.noctalia.enable = true;
      # plasma.enable = true;

      langs = {
        zeal.enable = true;
        direnv.enable = true;
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
