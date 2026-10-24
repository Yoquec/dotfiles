{
  inputs,
  yoq,
  burrow,
  ...
}:
{
  flake-file.inputs.darwin.url = "github:LnL7/nix-darwin/nix-darwin-26.05";

  yoq.darwin = {
    includes = [
      burrow.base
      yoq.nix
      yoq.theme
      yoq.ghostty
      yoq.aerospace
      yoq.betterdisplay
    ];

    homeManager =
      { pkgs, ... }:
      {
        stylix.fonts.monospace = {
          package = pkgs.nerd-fonts.code-new-roman;
          name = "CodeNewRoman Nerd Font Mono";
        };
      };

    darwin =
      { pkgs, ... }:
      {
        system.defaults.dock.autohide = true;
        system.defaults.trackpad.Clicking = true;
        system.defaults.trackpad.TrackpadThreeFingerDrag = true;
        system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
        system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;

        # TODO: Integrate with theme switching
        system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";

        system.keyboard.enableKeyMapping = true;
        system.keyboard.remapCapsLockToEscape = true;

        security.pam.services.sudo_local.touchIdAuth = true;

        fonts.packages = with pkgs; [
          nerd-fonts.code-new-roman
        ];

        environment.systemPackages = with inputs.darwin.packages.${pkgs.stdenvNoCC.hostPlatform.system}; [
          darwin-option
          darwin-rebuild
          darwin-version
          darwin-uninstaller
        ];
      };
  };
}
