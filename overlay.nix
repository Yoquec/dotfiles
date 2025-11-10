final: prev:
let
  tmuxPackages = prev.callPackage ./packages/tmuxPackages.nix { };
  emaview = prev.callPackage ./packages/emaview.nix { };
in
{
  inherit tmuxPackages emaview;
}
