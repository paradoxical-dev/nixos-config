{ config, lib, pkgs, ... }:

{
  config = {
    userSettings = { 
      terminal = "ghostty";
      browser = "librewolf";
      cli = "base";
      langs = {
        node = {
	  enable = true;
	  nodemon.enable = true;
	};
	python.enable = true;
      };
    };
  };
}
