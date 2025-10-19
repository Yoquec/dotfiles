{
  description = "Home Manager configuration of yoquec";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
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
  };
  outputs =
    inputs:
    {
      overlays.default = import ./overlay.nix;

      modules = {
        home = ./modules/home;
        default = ./modules/default;
      };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.self.overlays.default ];
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
