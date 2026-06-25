{ pkgs, ... }:

{
  systemSettings = {
    users = [ "gitmoney" ];
    adminUsers = [ "gitmoney" ];

    kernel.type = "latest";
    security = {
      firewall = {
        enable = true;
        allowSSH = true;
      };
      fail2ban.enable = true;
      unbound.enable = true;
      hardening.enable = true;
    };

    extra-documentation.enable = true;

    bluetooth.enable = true;
    printing.enable = true;

    fonts = {
      std = with pkgs; [ victor-mono roboto-mono ];
      nerd = with pkgs; [ nerd-fonts.jetbrains-mono nerd-fonts.fira-code ];
    };

    # gnome.enable = true;
    niri.enable = true;
  };

  # nix-mineral settings
  nix-mineral.settings.entropy.jitterentropy = false; # disable jitterentropy (conflicts on this machine)

  # user settings
  users.users.gitmoney.description = "gitmoney";
  home-manager.users.gitmoney.userSettings = {
    name = "gitmoney";
    userEmail = "jaredonnell21@gmail.com";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
