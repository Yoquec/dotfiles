{
  description = "Home Manager configuration of yoquec";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:yoquec/nvim";
      flake = false;
    };
  };
  outputs =
    inputs:
    let
      forEachSystem =
        f:
        inputs.nixpkgs.lib.genAttrs (import inputs.systems) (
          system:
          f {
            pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [ inputs.self.overlays.default ];
            };
          }
        );
    in
    {
      overlays.default = import ./overlay.nix;

      modules = {
        identity = ./modules/identity.nix;
        home.development = ./modules/home/development;
        home.media = ./modules/home/media;
        home.writing = ./modules/home/writing;
        home.socials = ./modules/home/socials;
      };

      formatter = forEachSystem ({ pkgs, ... }: pkgs.nixfmt-tree);

      packages = forEachSystem (
        { pkgs, ... }:
        {
          homeConfigurations = {
            yoquec = inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./configurations/yoquec/home.nix ];
              extraSpecialArgs = {
                inherit (inputs) neovim;
              };
            };

            reprocex = inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./configurations/reprocex/home.nix ];
              extraSpecialArgs = {
                inherit (inputs) neovim;
              };
            };
          };
        }
      );
    };
}
