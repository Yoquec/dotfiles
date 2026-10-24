# bootstraps flake-file's generator and den's dendritic wiring, pulling in
# yoquec-dotfiles's shared-inputs.
{ inputs, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
    inputs.yoquec-dotfiles.flakeModules.shared-inputs
  ];

  flake-file.inputs.yoquec-dotfiles.url = "github:yoquec/dotfiles";
}
