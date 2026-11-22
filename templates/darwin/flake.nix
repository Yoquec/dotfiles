# DO-NOT-EDIT. This file was auto-generated using github:denful/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "A nix-darwin host preconfigured with yoq.darwin";

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (import-tree ./modules);

  inputs = {
    yoquec-dotfiles.url = "git+https://github.com/yoquec/dotfiles";
    nixpkgs.follows = "yoquec-dotfiles/nixpkgs";
    flake-parts.follows = "yoquec-dotfiles/flake-parts";
    import-tree.follows = "yoquec-dotfiles/import-tree";
    flake-file.follows = "yoquec-dotfiles/flake-file";
    den.follows = "yoquec-dotfiles/den";
  };
}
