{
  config,
  lib,
  ...
}:

# INFO: Add starship prompt to shell

let
  cfg = config.userSettings.starship;
in
{
  options = {
    userSettings.starship = {
      enable = lib.mkEnableOption "Enable starship prompt";
    };
  };
  config = lib.mkIf cfg.enable {
    # home.packages = with pkgs; [ starship ];
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        format = lib.concatStrings [
          "[┌](fg:#999999)"
          "[ 󱜿 ](bg:purple fg:black)"
          "[](fg:purple bg:black)"
          "$directory"
          "$git_branch"
          "$git_status\n"
          "[└](fg:#999999) "
          "$character"
        ];
        directory = {
          format = "[](fg:blue bg:none)[ $path ](bg:blue fg:black)[](fg:blue bg:none)";
        };
        git_branch = {
          symbol = "";
          format = "[](fg:bright-cyan bg:black)[ $symbol $branch ](bg:bright-cyan fg:black)";
        };
        git_status = {
          untracked = "";
          modified = "";
          staged = "";
          format = "[$untracked$modified$staged ](bg:bright-cyan fg:black)[](fg:bright-cyan bg:black)";
        };
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };
      };
    };
  };
}
