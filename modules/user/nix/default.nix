{ pkgs, ... }:

# INFO: Defines the stateVersion and some default nix QoL packages

{
  config = {
    home.stateVersion = "25.11";
    home.packages = with pkgs; [
      nil
      nixd
      nixdoc
      nh
    ];
  };
}
