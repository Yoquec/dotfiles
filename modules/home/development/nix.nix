{
  lib,
  pkgs,
  config,
  ...
}: {
  # To use the `nix` from `inputs.nixpkgs` on templates using the standalone `home-manager` template
  # See: https://raw.githubusercontent.com/juspay/nixos-unified-template/refs/heads/main/modules/home/nix.nix

  # `nix.package` is already set if on `NixOS` or `nix-darwin`.
  options.modules.development.nix = {
    enable = lib.mkEnableOption "Configure nix (with nix)";
    installBinary = lib.mkEnableOption "Bring an external nix package";
  };

  config = lib.mkIf config.modules.development.nix.enable {
    nix.package = lib.mkDefault pkgs.nix;
    nix.settings.experimental-features = lib.mkDefault ["nix-command" "flakes"];
    home.packages = lib.mkIf config.modules.development.nix.installBinary [
      config.nix.package
    ];
  };
}
