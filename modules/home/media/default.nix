{ flake, lib, ... }:
import "${flake.inputs.self}/lib/autowire/mkModule.nix" { inherit lib; } {
  path = ./.;
  name = "media";
}
