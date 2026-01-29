{
  pkgs,
  jail,
  config,
  lib,
  ...
}:
let
  inherit (config.modules.development.ai) claude-code;

  isLinux = lib.hasInfix "linux" pkgs.stdenv.hostPlatform.system;

  claude-code-jail = jail "claude" pkgs.claude-code (
    with jail.combinators;
    let
      # Path to certificate bundle
      certpath = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    in
    [
      tools.git
      tools.bash

      mount-cwd
      network

      # Allow access to claude-specific configuration files
      # See: https://github.com/srid/nixos-config/blob/4919c45017f006a00b7224a620d98315fdd565d1/modules/flake-parts/claude-sandboxed.nix#L24-L30
      # See: https://alexdav.id/projects/jail-nix/combinators/#noescape
      (try-readwrite (noescape "~/.claude"))
      (try-readwrite (noescape "~/.claude.json"))

      # Properly resolve ca certificates (fix UNABLE_TO_GET_ISSUER_CERT_LOCALLY)
      # See: https://github.com/anthropics/claude-code/issues/2816
      (readonly certpath)
      (set-env "NODE_EXTRA_CA_CERTS" certpath)
    ]
  );
in
{
  options.modules.development.ai.claude-code = {
    enable = lib.mkEnableOption "Enable claude-code";
  };

  config = lib.mkIf (claude-code.enable && isLinux) ({
    home.packages = [ claude-code-jail ];
  });
}
