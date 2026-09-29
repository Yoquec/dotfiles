{
  flake,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config) xdg home;
  inherit (flake.inputs) agenix;

  pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVuZC8VJWJKbi+wa3S8iXpp8/6EQZ53e4SBQ5wtWBOS yoquec@framework";

  identity = {
    username = "yoquec";
    fullname = "Alvaro Viejo";
    email = "alvaro.viejo@yoquec.com";
  };

  wiki.directory = "${home.homeDirectory}/Nextcloud/Notes/";
in
{
  imports = [
    ../../../modules/home
    ../../../modules/home/agenix-rekey.nix
    ../../../modules/shared/jail.nix
    ../../../modules/shared/identity.nix
    ../../../modules/shared/theme.nix
    agenix.homeManagerModules.default
  ];
  inherit identity;

  age.rekey.hostPubkey = pubkey;

  home.username = identity.username;
  home.homeDirectory = "/home/${identity.username}";
  home.stateVersion = "25.11";

  modules.wayland.enable = true;
  modules.stylix.enable = true;
  modules.socials.enable = true;
  modules.media.enable = true;
  modules.development.enable = true;
  modules.development.ai.enable = true;

  modules.writing = {
    enable = true;
    inherit wiki;
  };

  nix.gc.dates = "weekly";

  # TODO: Should be moved to their own modules
  home.file = {
    "${xdg.configHome}/wireplumber".source = ../../../dotfiles/wireplumber;
  };

  home.packages = with pkgs; [
    age
    age-plugin-yubikey
    tlrc
    ungoogled-chromium
  ];

  # HACK: Arch linux-related workarounds
  programs.ghostty.package = lib.mkForce (pkgs.callPackage ./ghostty-polyfill.nix { });
  services.blueman-applet.package = lib.mkForce (pkgs.callPackage ./blueman-polyfill.nix { });
  programs.swaylock.package = lib.mkForce null;
  wayland.windowManager.sway.package = lib.mkForce null;
  services.dunst.enable = lib.mkForce false;
  services.ssh-agent.enable = lib.mkForce true;
  home.sessionVariables.QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";

  # Accent support in GTK applications (e.g. Ghostty)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
    ];
  };

  wayland.windowManager.sway.config.startup = [
    { command = "fcitx5 -d"; }
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
