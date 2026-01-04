# Flake-parts module aggregator
# Note: These must be path imports because self.flakeModules isn't available
# during flake module evaluation (would cause infinite recursion)
{ inputs, ... }:
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];
}
