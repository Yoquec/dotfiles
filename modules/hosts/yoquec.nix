{ den, yoq, ... }:
{
  den.aspects.yoquec = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      yoq.nix
      yoq.zk
      yoq.development
    ];

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}
