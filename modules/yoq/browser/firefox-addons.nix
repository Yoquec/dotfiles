# A standalone pkgs instance just for addon packages, exposed as the
# `firefoxAddons` module arg to every other file in this aspect: `pkgs` is
# itself sourced from _module.args (home-manager builds it from
# config.nixpkgs.*), so a module that both consumes pkgs and contributes a
# new _module.args entry is a self-reference. host.system is independent of
# that fixpoint. See https://den.denful.dev/guides/nixpkgs/#a-module-argument-instead
{ inputs, ... }:
{
  flake-file.inputs.nur = {
    url = "github:nix-community/NUR";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  yoq.browser.homeManager =
    { host, ... }:
    {
      _module.args.firefoxAddons =
        (import inputs.nixpkgs {
          inherit (host) system;
          overlays = [ inputs.nur.overlays.default ];
        }).nur.repos.rycee.firefox-addons;
    };
}
