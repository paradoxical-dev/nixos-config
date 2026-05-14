{
  description = "Wubba lubba dub dub";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-mineral.url = "github:cynicsketch/nix-mineral/";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:

    let
      lib = nixpkgs.lib;
      hosts = builtins.filter (x: x != null && x != "TEMPLATE") (
        lib.mapAttrsToList (k: v: if (v == "directory") then k else null) (builtins.readDir ./hosts)
      );
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = lib.nixosSystem {
            modules = [
              # host specific
              { config.networking.hostName = host; }
              (./hosts + "/${host}")

              # system modules
              ./modules/system

              # home-manager
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
              }
            ];

            specialArgs = { inherit inputs; };
          };
        }) hosts
      );
    };
}
