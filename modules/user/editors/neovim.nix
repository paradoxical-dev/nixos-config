{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.neovim;
in
{
  options = {
    userSettings.neovim = {
      enable = lib.mkEnableOption "Enable Neovim";
    };
  };
  config = lib.mkIf cfg.enable {
    # handle neovim conf outside of home-manager
    home.packages = with pkgs; [
      neovim
      tree-sitter
      gcc # for installing tree-sitter parsers
      nodejs # for installing lsp servers
      sqlite # for zeal plugin
      jq # for kulala plugin
    ];
  };
}
