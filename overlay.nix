final: prev:
let
  tmuxPackages = prev.callPackage ./packages/tmuxPackages.nix { };
in
{
  inherit tmuxPackages;
}
