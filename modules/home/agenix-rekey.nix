# agenix-rekey configuration for automatic secret rekeying
{
  config,
  flake,
  lib,
  ...
}:
let
  inherit (flake) inputs self;
in
{
  imports = [
    # Temporary workaround for inputs.agenix-rekey.homeManagerModules.default
    # See: https://github.com/oddlama/agenix-rekey/issues/133#issuecomment-3732490702
    (import "${inputs.agenix-rekey}/modules/agenix-rekey.nix" inputs.nixpkgs)
  ];

  # Enable agenix daemon when needed
  # See: https://github.com/nix-community/home-manager/issues/5452
  systemd.user.startServices = "sd-switch";

  age.rekey = {
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

    # Store rekeyed secrets locally per-user
    storageMode = "local";
    localStorageDir = lib.mkDefault (self + "/secrets/rekeyed/${config.home.username}");

    # Host pubkey must be set per-host in configurations/home/<user>/default.nix:
    # age.rekey.hostPubkey = "ssh-ed25519 AAAA...";
  };
}
