{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.tmux;
in
{
  options = {
    userSettings.tmux = {
      enable = lib.mkEnableOption "Enable tmux";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      mouse = true;
      prefix = "C-s";
      keyMode = "vi";
      baseIndex = 1;
      escapeTime = 0;
      terminal = "tmux-256color";
      plugins = with pkgs.tmuxPlugins; [
        tmux-fzf
        battery
        resurrect
      ];
      extraConfig = ''
        # BASE #

        # source theme file
        source-file ${config.home.homeDirectory}/.config/tmux/colors.conf

        # colors
        set-option -ga terminal-overrides ",xterm-256color:Tc"

        # KEYBINDS #

        # splits
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # nav
        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R
        bind-key -r C-h select-window -t :-
        bind-key -r C-l select-window -t :+

        # extra
        unbind r
        bind r source ~/.config/tmux/tmux.conf
        bind C-c run "tmux save buffer - | xclip -i -sel clip"
        bind C-v run "tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer"

        # STATUS LINE #

        # options
        set-option -g status-position top
        set -g renumber-windows on
        set -g status-style bg=default
        set-option -g message-style 'fg=#94e2d5,bg=default'
        set-option -g message-command-style 'fg=#94e2d5,bg=default'

        # vars
        prefix_color="#{?client_prefix,#{@secondary_accent},#{@main_accent}}"
        window_symbol="󰖯"
        monitor_symbol=""
        active_space_symbol=""
        inactive_space_symbol=""
        left_section_icon=""
        right_section_icon=""
        hostname_icon=""
        ip_icon=""

        # left side #

        # session name
        set-option -g status-left-length 150
        set-option -g status-left "\
        #[fg=''${prefix_color}]''${left_section_icon}\
        #[fg=#{@text_on_accent},bg=''${prefix_color}]''${window_symbol} #S\
        #[fg=''${prefix_color},bg=default]''${right_section_icon} "

        # tabs
        set-window-option -g window-status-format "\
        #[fg=#{@gray_text},bg=default] ''${inactive_space_symbol}  #W "

        set-window-option -g window-status-current-format "\
        #[fg=#{@main_accent},bg=default] ''${active_space_symbol} \
        #[fg=bright,bg=default] #W "

        set-window-option -g window-status-separator ""

        # right side #

        set-option -g status-right "\
        #[fg=#{@gray_text},bg=default]''${hostname_icon} #h  \
        #[fg=#{@gray_text},bg=default]''${ip_icon} #(hostname -I | awk '{print $1}')  \
        #[fg=#{@secondary_accent},bg=default] ''${left_section_icon}\
        #[fg=#{@text_on_accent},bg=#{@secondary_accent}]''${monitor_symbol}  #{session_attached}\
        #[fg=#{@secondary_accent},bg=default]''${right_section_icon}"

        set-option -g status-right-length 100
      '';
    };
  };
}
