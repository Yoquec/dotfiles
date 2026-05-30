{
  pkgs,
  jail,
  config,
  lib,
  flake,
  ...
}:
let
  inherit (config.modules.development.ai) claude-code;
  inherit (flake.inputs) neovim;
  inherit (config.age) secrets;

  claude-code-jail = jail "claude" pkgs.claude-code (
    with jail.combinators;
    let
      # Path to certificate bundle
      certpath = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    in
    [
      tools.git
      tools.bash

      confirm-mount-cwd
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

      # Disable telemetry
      (set-env "DISABLE_TELEMETRY" "1")
      (set-env "DISABLE_ERROR_REPORTING" "1")

      # Perplexity MCP server: binary in PATH, API key injected before bubblewrap starts
      (add-pkg-deps [ pkgs.perplexity-mcp-server ])
      (read-env-file "PERPLEXITY_API_KEY" secrets.perplexity.path)

      # Adds neovim editor support
      (add-pkg-deps [ pkgs.neovim ])
      (ro-bind "${neovim}" (noescape "~/.config/nvim"))
      (try-readonly (noescape "~/.local/share/nvim"))
      (try-readwrite (noescape "~/.local/state/nvim"))
      (try-readwrite (noescape "~/.local/share/nvim/lazy/nvim-treesitter/parser"))
      (set-env "EDITOR" "nvim")
    ]
  );
in
{
  options.modules.development.ai.claude-code = {
    enable = lib.mkEnableOption "Enable claude-code";
  };

  config = lib.mkIf (claude-code.enable && pkgs.stdenv.isLinux) {
    age.secrets.perplexity.rekeyFile = ../../../../secrets/perplexity.age;

    programs.claude-code = {
      enable = true;
      package = claude-code-jail;
    };
  };
}
