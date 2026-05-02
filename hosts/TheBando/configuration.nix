{ config, pkgs, ... }:

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
    isNormalUser = true;
    description = "gitmoney";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    	obsidian
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     tmux
     fzf
  ];

  system.stateVersion = "25.11";
}
