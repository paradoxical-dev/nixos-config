{ pkgs, ... }:

# INFO: The default ocnfiguration that will (should) be present on all machines

{
  # default packages to always include
  environment.systemPackages = with pkgs; [
    git
    neovim
    man-pages
    man-pages-posix
    gnupg
  ];

  # zones / locale
  time.timeZone = "America/Chicago";
  services.timesyncd.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # documentation
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.man.cache.enable = true;
  documentation.info.enable = true;

  # zsh > bash
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  # enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # networking
  networking.networkmanager.enable = true;

  # limit journald
  services.journald.extraConfig = "SystemMaxUse=50M\nSystemMaxFiles=5";
  services.journald.rateLimitBurst = 500;
  services.journald.rateLimitInterval = "30s";

  # binary caches
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trusted-users = [ "@wheel" ];
  };

  # bootloader (grub)
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "sleek-grub-theme";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "sandesh236";
      repo = "sleek--themes";
      rev = "master";
      hash = "sha256-E3DSOZlszBRy2F172L7ZSSsDlkk3n9jGXl4hRWv2WF8=";
    };
    installPhase = ''
      cp -r "$src/Sleek theme-dark/sleek" $out
    '';
  };
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.device = "nodev";

  # silent boot
  boot.kernelParams = [
    "quiet"
    "splash"
    "vga=current"
    "rd.systemd.show"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;

  # boot animation
  boot.plymouth = {
    enable = true;
    theme = "cross_hud";
    themePackages = [
      pkgs.adi1090x-plymouth-themes
    ];
  };
}
