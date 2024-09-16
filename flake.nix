{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager , ... }@inputs:
	  let
		lib = nixpkgs.lib;
	  in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./configuration.nix

					home-manager.nixosModules.home-manager{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.spike = import ./home.nix;
					}
				];
			};
		};
	  };
}
