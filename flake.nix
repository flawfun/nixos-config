{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:infinidoge/nix-minecraft";

    neovim-config = {
      url = "github:redhawk18/neovim-config";
      flake = false;
    };

    nur-xddxdd.url = "github:xddxdd/nur-packages";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        Dunker = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ ./hosts/dunker/configuration.nix ];
        };


    };
}
