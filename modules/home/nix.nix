{
  config,
  pkgs,
  lib,
  ...
}: {
  # To use the `nix` from `inputs.nixpkgs` on templates using the standalone `home-manager` template
  # See: https://raw.githubusercontent.com/juspay/nixos-unified-template/refs/heads/main/modules/home/nix.nix

  # `nix.package` is already set if on `NixOS` or `nix-darwin`.
  options.modules.nix.enable = lib.mkEnableOption "Bring an external nix package";

  config = lib.mkIf config.modules.nix.enable {
    nix.package = lib.mkDefault pkgs.nix;
    home.packages = [
      config.nix.package
    ];
  };
}
