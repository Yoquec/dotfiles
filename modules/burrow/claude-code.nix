# https://github.com/anthropics/claude-code
{ yoq, ... }:
{
  burrow.claude-code = {
    includes = [ yoq.lib.jail ];

    homeManager =
      { jail, pkgs, ... }:
      let
        certfile = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

        jailedClaude = jail "claude" pkgs.claude-code (
          with jail.combinators;
          [
            confirm-mount-cwd
            network
            time-zone

            agentsandbox.bash
            agentsandbox.neovim

            (add-pkg-deps [ pkgs.python3Minimal ])

            # claude's own persistent config/session state
            # see: https://alexdav.id/projects/jail-nix/combinators/#noescape
            (try-readwrite (noescape "~/.claude"))
            (try-readwrite (noescape "~/.claude.json"))

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
