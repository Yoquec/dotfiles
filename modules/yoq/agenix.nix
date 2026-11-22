{ inputs, lib, ... }:
{
  flake-file.inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix-rekey.url = "github:oddlama/agenix-rekey";
  };

  yoq.agenix = {
    homeManager = {
      imports = [
        inputs.agenix.homeManagerModules.default
        inputs.agenix-rekey.homeManagerModules.default
      ];

      age.rekey.storageMode = lib.mkDefault "local";
    };
  };
}
