{ pkgs, ... }:

{
  systemSettings = {
    users = [ "YOUR_USERNAME" ];
    adminUsers = [ "ADMIN_USERNAME" ];
    kernel.type = "latest";
  };

  # user settings
  users.users.YOUR_USERNAME.description = "YOUR_USERNAME";
  home-manager.users.YOUR_USERNAME.userSettings = {
    name = "YOUR_USERNAME";
    email = "YOUR_EMAIL";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
