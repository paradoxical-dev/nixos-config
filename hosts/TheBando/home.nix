{ config, lib, pkgs, ... }:

{
  config = {
    userSettings = { 
      terminal = "ghostty";
      browser = "librewolf";
    };
  };
}
