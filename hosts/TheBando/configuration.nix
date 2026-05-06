{ pkgs, ... }:

{

  systemSettings = {
    users = [ "gitmoney" ];
    adminUsers = [ "gitmoney" ];
    bluetooth.enable = true;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # user settings
  home-manager.users.gitmoney.userSettings = {
    name = "gitmoney";
    email = "jaredonnell21@gmail.com";
  };
  users.users.gitmoney = {
    description = "gitmoney";
    packages = with pkgs; [
      obsidian
    ];
  };

  # documentation
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.info.enable = true;
  documentation.doc.enable = true;
  documentation.man.generateCaches = true;
  documentation.dev.enable = true;
  documentation.nixos.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
