{ inputs, lib, ... }:
{
  flake-file.inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix-rekey.url = "github:oddlama/agenix-rekey";
  };

  burrow.agenix = {
    homeManager = {
      imports = [
        inputs.agenix.homeManagerModules.default
        inputs.agenix-rekey.homeManagerModules.default
      ];

      age.rekey = {
        storageMode = lib.mkDefault "local";

        # yubikey identities used for decryption
        # See: https://github.com/oddlama/agenix-rekey/pull/28
        masterIdentities = [
          {
            identity = ../../secrets/identities/d8a12e1d.pub;
            pubkey = "age1yubikey1qwp387mvs0n3jana7mmhqqaphaljdyaf4wf42xrxsknygzugs2yczvc60hu";
          }
          {
            identity = ../../secrets/identities/d3f3fff5.pub;
            pubkey = "age1yubikey1q0vg69n4ksl2kk2ahqqhellvw33hkl4al26rpa2hsmfc9teamny36d06sca";
          }
        ];
      };
    };
  };
}
