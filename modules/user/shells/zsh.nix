{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.zsh.enable;
  hist_size = 10000;
in
{
  options = {
    userSettings.zsh = {
      enable = lib.mkEnableOption "Enable zsh";
    };
  };
  config = lib.mkIf cfg {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        # system
        update = "nh os switch ${config.userSettings.dotfilesDir}#$(hostname)";
        cleanup = "sudo nix-collect-garbage -d && nix-collect-garbage -d";

        # base
        c = "clear";
        ff = "fastfetch";
        fe = "yazi";
        ls = "eza -a --icons";
        ll = "eza -al --icons";
        lt = "eza -a --tree --level=1 --icons";
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
        gsp = "git stash; git pull";
        gcheck = "git checkout";
        gcredential = "git config credential.helper store";
        gg = "lazygit";
        gl = "fzf-git-log";
        gd = "fzf-git-diff";
      };
      history = {
        size = hist_size;
        save = hist_size;
        share = true;
        append = true;
        ignoreSpace = true;
        ignoreDups = true;
        ignoreAllDups = true;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "sudo"
          "copybuffer"
          "copyfile"
          "dirhistory"
        ];
      };
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "d7e0234";
            sha256 = "sha256-8atbysoOyCBW2OYKmdc91x9V/Mk3eyg3hvzvhJpQ32w=";
          };
        }
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
      initContent = ''
        bindkey -v

        # PATH EXTENSIONS #
        export PATH="$HOME/.config/emacs/bin:$PATH"

        # FZF #
        eval "$(fzf --zsh)"
        source $HOME/.config/zsh/fzf-colors.sh
        zstyle ":completion:*" menu no
        zstyle ":fzf-tab:*" use-fzf-default-opts yes

        # reapply fzf bindings after zsh-vi-mode resets keymaps
        autoload -Uz add-zsh-hook

        _zvm_after_init_fzf_binds() {
          if typeset -f fzf-history-widget >/dev/null; then
            bindkey -M vicmd '^R' fzf-history-widget
            bindkey -M viins '^R' fzf-history-widget
          fi
        }

        # run after zsh-vi-mode finishes init
        add-zsh-hook precmd _zvm_after_init_fzf_binds

        # directories
        zstyle ":fzf-tab:complete:cd:*" fzf-preview 'eza -1 --color=always $realpath'

        # service status
        zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

        # file content
        zstyle ":fzf-tab:complete:*:*" fzf-preview 'less $realpath'
        export LESSOPEN="|$HOME/scripts/lessfilter.sh %s"
        zstyle ":fzf-tab:complete:*:options" fzf-preview 
        zstyle ":fzf-tab:complete:*:argument-1" fzf-preview

        # env vars
        zstyle ":fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*" \
        fzf-preview 'echo ''${(P)word}'

        # dynamic man pages for commands
        zstyle ":fzf-tab:complete:-command-:*" fzf-preview \
        '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "''${(P) word}"'

        # VI MODE #
        export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK        
        export ZVM_KEYTIMEOUT=0
        export ZVM_VI_HIGHLIGHT_BACKGROUND=#45475b

        # STARSHIP #
        eval "$(starship init zsh)"
      '';
    };

    # symlink fzf scripts
    home.file.".config/zsh/fzf-colors.sh".text = builtins.readFile ../cli/fzf/fzf-colors.sh;
  };
}
