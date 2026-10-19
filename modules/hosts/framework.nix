{ yoq, ... }:
{
  den.aspects.framework = {
    includes = [ yoq.nix ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.hello ];

        # home-manager's default (useUserPackages = false) installs user
        # packages via a nix-env-style profile build at activation time,
        # which needs write access to the Nix store. A NixOS VM's store is a
        # read-only mount of the host's, so that build fails with
        # "opening file '....drv': No such file or directory". Installing
        # via users.users.<name>.packages instead bakes packages into the
        # system closure at build time, sidestepping the issue entirely.
        home-manager.useUserPackages = true;
      };
  };
}
