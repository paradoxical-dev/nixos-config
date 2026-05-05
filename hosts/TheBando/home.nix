{ config, lib, pkgs, ... }:

{
  config = {
    userSettings = { 
      terminal = "ghostty";
      browser = "librewolf";
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
