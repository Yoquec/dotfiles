# flake-parts module exporting shared inputs for consumers of flake templates
{ ... }:
{
  flake.flakeModules.default = {
    flake-file.inputs = {
      # nixpkgs/flake-parts/flake-file/import-tree get defaulted by
      # flake-file's own dendritic bundle (modules/dendritic/*.nix), and den
      # gets defaulted by den's own flakeModules.dendritic -- each `url`
      # (and flake-parts's nested nixpkgs-lib follow) has to be cleared back
      # to empty/null here, or the generated flake.nix ends up with both a
      # `url` and a `follows` on the same input, which is invalid.
      nixpkgs = {
        url = "";
        follows = "yoquec-dotfiles/nixpkgs";
      };
      home-manager.follows = "yoquec-dotfiles/home-manager";
      darwin.follows = "yoquec-dotfiles/darwin";
      flake-parts = {
        url = "";
        inputs.nixpkgs-lib.follows = null;
        follows = "yoquec-dotfiles/flake-parts";
      };
      import-tree = {
        url = "";
        follows = "yoquec-dotfiles/import-tree";
      };
      flake-file = {
        url = "";
        follows = "yoquec-dotfiles/flake-file";
      };
      den = {
        url = "";
        follows = "yoquec-dotfiles/den";
      };
    };
  };
}
