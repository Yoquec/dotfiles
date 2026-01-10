# Sets up nixpkgs to contain the default package overlay
{ inputs, withSystem, ... }:
{
  # See: https://flake.parts/overlays.html?highlight=overlay#defining-an-overlay
  flake.overlays = {
    default =
      final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        {
          pkgs,
          config,
          system,
          ...
        }:
        {
          inherit (inputs.toolbox.packages.${system}) texttransform;

          # Expose this flake's packages
          inherit (config.packages)
            emaview
            tms
            tmswitch
            tmsproject
            ;
        }
      );

    brokenPackages =
      final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { system, ... }:
        {
          inherit (inputs.emanote.packages.${system}) emanote;
        }
      );
  };

  # Consume the default overlay in this flake
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.self.overlays.default
          inputs.self.overlays.brokenPackages
        ];
        config = {
          allowUnfree = true;
          allowAliases = true;
        };
      };
    };
}
