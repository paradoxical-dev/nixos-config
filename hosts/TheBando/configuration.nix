{ pkgs, ... }:

{
  systemSettings = {
    users = [ "gitmoney" ];
    adminUsers = [ "gitmoney" ];
    kernel.type = "latest";
    extra-documentation.enable = true;
    bluetooth.enable = true;
    printing.enable = true;
    fonts = {
      std = with pkgs; [ victor-mono ];
      nerd = with pkgs; [ nerd-fonts.jetbrains-mono ];
    };
    gnome.enable = true;
  };

  # user settings
  users.users.gitmoney.description = "gitmoney";
  home-manager.users.gitmoney.userSettings = {
    name = "gitmoney";
    email = "jaredonnell21@gmail.com";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
