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
          inherit (inputs.emanote.packages.${system}) emanote;

          # Expose this flake's packages
          inherit (config.packages)
            emaview
            tms
            tmswitch
            tmsproject
            ;
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
        ];
        config = {
          allowUnfree = true;
          allowAliases = true;
        };
      };
    };
}
