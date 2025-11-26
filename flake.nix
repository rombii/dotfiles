{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nvf = {
      url = "github:notashelf/nvf?ref=v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = { 
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {self, nixpkgs, nvf, stylix, home-manager, ... }: {
      packages."x86_64-linux".default = 
      (nvf.lib.neovimConfiguration {
         pkgs = nixpkgs.legacyPackages."x86_64-linux";
         modules = [ "${./nvf-config.nix}" ];
      }).neovim;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [ 
          nvf.nixosModules.default
          stylix.nixosModules.default
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ibmorr = ./home.nix;
          }
	        ./configuration.nix
        ];
      };
    };
}    
