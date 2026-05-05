{ config, lib, pkgs, ... }:

{
    config = {
        userSettings = { 
            terminal = "ghostty";
            browser = "brave";
            cli = "extra";
            langs = {
                node = {
                    enable = true;
                    nodemon.enable = true;
                };
                python.enable = true;
                rust.enable = true;
            };
        };
    };
}
