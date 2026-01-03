{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    emanote = {
      url = "github:srid/emanote";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    neovim = {
      url = "github:yoquec/nvim";
      flake = false;
    };
    toolbox = {
      url = "github:yoquec/toolbox";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
  };
  outputs =
    inputs:
    {
      overlays.default = import ./overlay.nix;

      modules = {
        default = ./modules;
      };

      templates = {
        flake-parts = {
          path = ./templates/flake-parts;
          description = "Basic flake-parts bootstrap template";
        };
      };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        brokenPackagesOverlay = final: prev: {
          emanote = inputs.emanote.packages.${system}.emanote;
        };

        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.self.overlays.default
            inputs.toolbox.overlays.default
            brokenPackagesOverlay
          ];
        };
      in
      {
        formatter = pkgs.nixfmt-tree;

        packages = {
          homeConfigurations = {
            yoquec = inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./configurations/yoquec/home.nix ];
              extraSpecialArgs = {
                inherit (inputs) neovim;
              };
            };

            devcontainer = inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./configurations/devcontainer/home.nix ];
              extraSpecialArgs = {
                inherit (inputs) neovim;
              };
            };
          };
        };
      }
    );
}
