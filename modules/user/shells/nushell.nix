{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.nushell.enable;
in
{
  options = {
    userSettings.nushell = {
      enable = lib.mkEnableOption "Enable nushell";
    };
  };
  config = lib.mkIf cfg {
    programs.nushell = {
      enable = true;
      settings = {
        show_banner = false;
        edit_mode = "vi";
        completions.algorithm = "fuzzy";
        use_kitty_protocol = true;
      };
      envFile.text = ''
        $env.PROMPT_INDICATOR_VI_INSERT = "";
        $env.PROMPT_INDICATOR_VI_NORMAL = "";
      '';
      shellAliases = {
        # system
        update = ''nh os switch $"${config.userSettings.dotfilesDir}#(hostname)"'';
        # cleanup = "sudo nix-collect-garbage -d; nix-collect-garbage -d";

        # base
        c = "clear";
        ff = "fastfetch";
        fe = "yazi";
        # ls = "eza -a --icons";
        # ll = "eza -al --icons";
        # lt = "eza -a --tree --level=1 --icons";
        shutdown = "systemctl poweroff";
        v = "nvim";
        fk = "fzf-kill";
        fm = "fzf-man";
        fs = "fzf-ssh";

        # git
        gs = "git status";
        ga = "git add";
        gc = "git commit -m";
        gp = "git push";
        gpl = "git pull";
        gst = "git stash";
        # gsp = "git stash; git pull";
        gcheck = "git checkout";
        gcredential = "git config credential.helper store";
        gg = "lazygit";
        gl = "fzf-git-log";
        gd = "fzf-git-diff";
      };
      extraConfig = ''
        # source fzf script
        use ~/.config/nushell/fzf.nu

        # had to move multi command aliases to function to avoid eager eval
        def cleanup [] {
          sudo nix-collect-garbage -d
          nix-collect-garbage -d
        }

        def gsp [] {
          git stash
          git pull
        }
      '';
      plugins = with pkgs.nushellPlugins; [
        formats
        polars
        query
      ];
    };

    # symlink fzf script
    home.file.".config/nushell/fzf.nu".source = ./scripts/fzf.nu;

    # carapace for command completion
    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    # extra deps
    home.packages = with pkgs; [
      nufmt
      tree
    ];
  };
}
