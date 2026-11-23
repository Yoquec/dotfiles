{ den, yoq, ... }:
{
  den.aspects.yoquec = {
    includes = [
      yoq.primary-user
      den.batteries.define-user
      den.batteries.host-aspects
      yoq.nix
      yoq.zk
      yoq.development
      (yoq.identity {
        name = "Alvaro Viejo";
        email = "alvaro.viejo@yoquec.com";
      })
    ];
  };
}
