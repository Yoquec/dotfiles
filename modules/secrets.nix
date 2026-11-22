{ inputs, burrow, ... }:
{
  imports = [ inputs.agenix-rekey.flakeModule ];

  den.aspects.yoquec = {
    includes = [ burrow.agenix ];
    homeManager = {
      age.rekey = {
        localStorageDir = ../secrets/rekeyed/yoquec;
        hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVuZC8VJWJKbi+wa3S8iXpp8/6EQZ53e4SBQ5wtWBOS yoquec@framework";
      };
    };
  };
}
