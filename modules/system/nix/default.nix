{ config, pkgs, ... }:

# INFO: Sets some default nix settings. 
# Also sets nix-ld up; will update as needed

{
  config = {
    nix = {
      package = pkgs.nix;
      settings = {
        substituters = [
          "https://cache.nixos.org"
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        trusted-users = config.systemSettings.adminUsers ++ [ "@wheel" ];
        auto-optimise-store = true;
        download-buffer-size = 500000000;
      };
    };
    programs.nix-ld = {
      enable = true;
      libraries = [
        pkgs.stdenv.cc.cc
      ];
    };
    system.stateVersion = "25.11";
  };
}
