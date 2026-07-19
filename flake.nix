{
  inputs = {
    self = {
      lfs = true;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixos-unified.url = "github:srid/nixos-unified";
    jail-nix.url = "sourcehut:~alexdavid/jail.nix";
    systems.url = "github:nix-systems/default";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    neovim = {
      url = "github:yoquec/nvim";
      flake = false;
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.flake-parts.follows = "flake-parts";
    };

    toolbox = {
      url = "github:yoquec/toolbox";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.flake-parts.follows = "flake-parts";
    };

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
      };
    };
  };
  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
      systems = import (inputs.systems);
    };
}
