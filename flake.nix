{
  description = "Wubba lubba dub dub";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-mineral.url = "github:cynicsketch/nix-mineral/";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:

    let
      # pkgs = import nixpkgs {
      #   config = {
      #     allowUnfree = true;
      #     allowUnfreePredicate = (_: true);
      #     permittedInsecurePackages = [
      #       # NOTE: any packages listed here will still need to be enabled via their module.
      #       # Therefore, this will not effect ur system unless you enable it.
      #       "webull-desktop-9.3.0"
      #     ];
      #   };
      #   overlays = [ ];
      # };

      # pkgs-stable = import inputs.nixpkgs-stable {
      #   config = {
      #     allowUnfree = true;
      #     allowUnfreePredicate = (_: true);
      #   };
      # };

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
                  # inherit pkgs;
                  # inherit pkgs-stable;
                };
              }
            ];

            specialArgs = {
              inherit inputs;
              # inherit pkgs;
              # inherit pkgs-stable;
            };
          };
        }) hosts
      );
    };
}
