{
  pkgs,
  jail,
  config,
  lib,
  ...
}:
let
  inherit (config.modules.development.ai) opencode;
  inherit (config.age) secrets;

  isLinux = lib.hasInfix "linux" pkgs.stdenv.hostPlatform.system;

  settings = {
    theme = "opencode";
    provider.mistral = {
      type = "api";
      key = "{env:MISTRAL_API_KEY}";
    };
  };

  opencode-jail = jail "opencode" pkgs.opencode (
    with jail.combinators;
    [
      # Allow access to the current running directory
      # See: https://alexdav.id/projects/jail-nix/combinators/#noescape
      (readwrite (noescape "\"$PWD\""))
      (readonly "${config.xdg.configHome}/opencode")

      network

      tools.git
      tools.bash

      # Load the mistral api key file into bubblewrap's environment
      (read-env-file "MISTRAL_API_KEY" secrets.mistral.path)

      # Disable automatic LSP installation
      # See: https://opencode.ai/docs/lsp/#configure:~:text=OPENCODE_DISABLE_LSP_DOWNLOAD
      (set-env "OPENCODE_DISABLE_LSP_DOWNLOAD" "true")
    ]
  );
in
{
  options.modules.development.ai.opencode = {
    enable = lib.mkEnableOption "Enable opencode";
  };

  config = {
    age.secrets = {
      mistral.rekeyFile = ../../../../secrets/mistral.age;
    };

    programs.opencode = lib.mkIf (opencode.enable && isLinux) {
      enable = true;
      package = opencode-jail;
      inherit settings;
    };
  };
}
