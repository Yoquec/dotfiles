{ inputs, ... }:
{
  flake-file.inputs.treefmt-nix.url = "github:numtide/treefmt-nix";

  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    programs.nixfmt.enable = true;
    programs.stylua.enable = true;
    settings.global.excludes = [
      "*.qcow2"
      "flake.lock"
      # snipmate format: indentation (literal tabs) is semantically
      # significant, no formatter understands this format safely.
      "*.snippets"
    ];
  };
}
