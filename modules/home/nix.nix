{
  config,
  pkgs,
  lib,
  ...
}: {
  # To use the `nix` from `inputs.nixpkgs` on templates using the standalone `home-manager` template
  # See: https://raw.githubusercontent.com/juspay/nixos-unified-template/refs/heads/main/modules/home/nix.nix

  # `nix.package` is already set if on `NixOS` or `nix-darwin`.
  options.nix.hasToBeDownloaded = lib.mkEnableOption "Bring an external nix package";

  config = lib.mkIf config.nix.hasToBeDownloaded {
    nix.package = lib.mkDefault pkgs.nix;
  };
}
