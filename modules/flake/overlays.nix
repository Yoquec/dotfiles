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

    jailedPackages =
      final: prev:
      inputs.jail-nix.lib.mkOverlay {
        inherit final prev;
        packages =
          combinators:
          with combinators;
          let
            # Path to certificate bundle
            certpath = "${prev.cacert}/etc/ssl/certs/ca-bundle.crt";
          in
          {
            claude-code = [
              network

              # Allow access to the current running directory
              # See: https://alexdav.id/projects/jail-nix/combinators/#readwrite-runtime-args
              readwrite-runtime-args

              # Allow access to claude-specific configuration files
              # See: https://github.com/srid/nixos-config/blob/4919c45017f006a00b7224a620d98315fdd565d1/modules/flake-parts/claude-sandboxed.nix#L24-L30
              # See: https://alexdav.id/projects/jail-nix/combinators/#noescape
              (try-readwrite (noescape "~/.claude"))
              (try-readwrite (noescape "~/.claude.json"))
              (try-readwrite (noescape "~/.cache/claude-cli-nodejs"))

              # Properly resolve ca certificates (fix UNABLE_TO_GET_ISSUER_CERT_LOCALLY)
              # See: https://github.com/anthropics/claude-code/issues/2816
              (try-readonly certpath)
              (set-env "NODE_EXTRA_CA_CERTS" certpath)
            ];
          };
      };
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
          inputs.self.overlays.jailedPackages
        ];
        config = {
          allowUnfree = true;
          allowAliases = true;
        };
      };
    };
}
