# bootstraps flake-file's generator and den's dendritic wiring, pulling in
# yoquec-dotfiles's shared inputs.
{ inputs, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
    inputs.yoquec-dotfiles.flakeModules.default
  ];

  # a git-based scheme (not the `github:` tarball/API fetcher) is required
  # here -- self.lfs = true (see modules/den.nix) only works when this flake
  # is located through a real git fetcher that can run git filters.
  flake-file.inputs.yoquec-dotfiles.url = "git+https://github.com/yoquec/dotfiles";
}
