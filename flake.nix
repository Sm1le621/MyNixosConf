{
  description = "My desktop conf, 2 chanell";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager/release-26.05"; inputs.nixpkgs.follows = "stable"; };
  };
  
  outputs = { self, stable, unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      nixpkgsConfig = { 
        allowUnfree = true; 
      };

      stable-pkgs = import stable {
      	inherit system;
      	config = nixpkgsConfig;
      };

      unstable-pkgs = import unstable {
        inherit system;
        config = nixpkgsConfig;
      };
    in
    {
      nixosConfigurations = {
        sm1le = stable.lib.nixosSystem {
          inherit system;

          specialArgs = {
          	stable = stable-pkgs;
          	unstable = unstable-pkgs;
          };
          
          modules = [
            { nixpkgs.pkgs = stable-pkgs; }
          
            ./hardware-configuration.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
            	home-manager.useGlobalPkgs = true;
            	home-manager.useUserPackages = true;
            	home-manager.extraSpecialArgs = { stable = stable-pkgs; unstable = unstable-pkgs; };
            	home-manager.users.sm1le = import ./homemanager.nix;
            }
          ];
        };
      };
	};
}
