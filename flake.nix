{
  description = "sb74's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, stylix, hyprland, agenix, impermanence, lanzaboote, nix-index-database, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = import ./lib { inherit inputs; };
  in
  {
    nixosConfigurations = {
      testbed = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          disko.nixosModules.disko
          agenix.nixosModules.default
          stylix.nixosModules.stylix
          impermanence.nixosModules.impermanence
          nix-index-database.nixosModules.nix-index
          home-manager.nixosModules.home-manager
          ./hosts/testbed
        ];
      };

      pc = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          disko.nixosModules.disko
          agenix.nixosModules.default
          stylix.nixosModules.stylix
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
          nix-index-database.nixosModules.nix-index
          home-manager.nixosModules.home-manager
          ./hosts/pc
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          disko.nixosModules.disko
          agenix.nixosModules.default
          stylix.nixosModules.stylix
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
          nix-index-database.nixosModules.nix-index
          home-manager.nixosModules.home-manager
          ./hosts/laptop
        ];
      };
    };
  };
}
