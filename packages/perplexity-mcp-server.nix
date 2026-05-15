{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {
  pname = "perplexity-mcp-server";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "perplexityai";
    repo = "modelcontextprotocol";
    rev = "dd5e0785520833ebc95d5e97c8fa68971dcae07b";
    hash = "sha256-hMIPsUsI1e8bOdPQ9t6m4/vGv07NCuC8wnYLUKolNOo=";
  };

  npmDepsHash = "sha256-UWxUjneYQeM9GlbIr/zW2TrZuPJ2QOTKwbXKNuVazFg=";

  meta = {
    description = "Perplexity AI MCP server";
    license = lib.licenses.mit;
    mainProgram = "perplexity-mcp";
  };
}
