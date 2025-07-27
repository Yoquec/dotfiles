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
  outputs = {
    nixpkgs,
    home-manager,
    neovim,
    ...
  }: let
    systems.x86_linux = {
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${systems.x86_linux.system};
    };
  in {
    homeConfigurations."yoquec" = home-manager.lib.homeManagerConfiguration {
      inherit (systems.x86_linux) pkgs;
      modules = [./configurations/yoquec/home.nix];
      extraSpecialArgs = {
        inherit neovim;
      };
    };
  };
}
