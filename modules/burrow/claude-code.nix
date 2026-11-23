# https://github.com/anthropics/claude-code
{ den, yoq, ... }:
{
  burrow.claude-code = {
    includes = [
      yoq.lib.jail
      (den.batteries.unfree [ "claude-code" ])
    ];

    homeManager =
      { jail, pkgs, ... }:
      let
        certfile = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

        jailedClaude = jail "claude" pkgs.claude-code (
          with jail.combinators;
          [
            # claude's persistent config/session state (incl. login credentials).
            # must come before confirm-mount-cwd so the cwd bind (more specific,
            # added later) overlays on top of this whole-home bind instead of
            # being shadowed by it.
            # see: https://alexdav.id/projects/jail-nix/combinators/#persist-home
            (persist-home "claude-code")

            confirm-mount-cwd
            network
            time-zone

            agentsandbox.bash
            agentsandbox.neovim

            (add-pkg-deps [
              pkgs.git
              pkgs.python3Minimal
            ])

            # resolve ca certificates (fixes UNABLE_TO_GET_ISSUER_CERT_LOCALLY)
            # see: https://github.com/anthropics/claude-code/issues/2816
            (readonly certfile)
            (set-env "SSL_CERT_FILE" certfile)

            (set-env "DISABLE_TELEMETRY" "1")
            (set-env "DISABLE_ERROR_REPORTING" "1")
          ]
        );
      in
      {
        programs.claude-code = {
          enable = true;
          package = jailedClaude;
          enableMcpIntegration = true;
        };
      };
  };
}
