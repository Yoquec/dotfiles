{ inputs, self, ... }:
{
  imports = [
    inputs.agenix-rekey.flakeModule
  ];

  perSystem =
    { system, ... }:
    {
      # See: https://flake.parts/options/agenix-rekey.html#opt-perSystem.agenix-rekey.homeConfigurations
      agenix-rekey.homeConfigurations = {
        # Home manager configurations are stored under legacyPackages
        # See: https://nixos-unified.org/guide/autowiring
        inherit (self.legacyPackages.${system}.homeConfigurations) yoquec;
      };
    };
}
