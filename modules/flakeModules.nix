# flake-parts module exporting shared inputs for consumers of flake templates
{ ... }:
{
  flake.flakeModules.shared-inputs = {
    flake-file.inputs = {
      nixpkgs = {
        url = ""; # override flake-file's dendritic bundle's own default
        follows = "yoquec-dotfiles/nixpkgs";
      };
      home-manager.follows = "yoquec-dotfiles/home-manager";
      darwin.follows = "yoquec-dotfiles/darwin";
      flake-parts.follows = "yoquec-dotfiles/flake-parts";
      import-tree.follows = "yoquec-dotfiles/import-tree";
      flake-file.follows = "yoquec-dotfiles/flake-file";
      den.follows = "yoquec-dotfiles/den";
    };
  };
}
