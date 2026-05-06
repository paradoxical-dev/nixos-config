{ pkgs, ... }:

{

  systemSettings = {
    users = [ "gitmoney" ];
    adminUsers = [ "gitmoney" ];
    kernel.type = "latest";
    bluetooth.enable = true;
    printing.enable = true;
    fonts = {
      std = with pkgs; [ victor-mono ];
      nerd = with pkgs; [ nerd-fonts.jetbrains-mono ];
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # user settings
  users.users.gitmoney.description = "gitmoney";
  home-manager.users.gitmoney.userSettings = {
    name = "gitmoney";
    email = "jaredonnell21@gmail.com";
  };

  # documentation
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.man.cache.enable = true;
  documentation.info.enable = true;
  documentation.doc.enable = true;
  documentation.dev.enable = true;
  documentation.nixos.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
