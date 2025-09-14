{
  description = "Home Manager configuration of yoquec";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # noevim dotfiles flake
    neovim = {
      url = "github:yoquec/nvim";
      flake = false;
    };
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      neovim,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      modules = {
        identity = ./modules/identity.nix;
        home.development = ./modules/home/development;
        home.media = ./modules/home/media;
        home.writing = ./modules/home/writing;
        home.socials = ./modules/home/socials;
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          homeConfigurations.yoquec = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./configurations/yoquec/home.nix ];
            extraSpecialArgs = {
              inherit neovim;
            };
          };

          homeConfigurations.reprocex = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./configurations/reprocex/home.nix ];
            extraSpecialArgs = {
              inherit neovim;
            };
          };
        }
      );
    };
}
