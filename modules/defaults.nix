{
  lib,
  burrow,
  den,
  ...
}:
{
  den.default.includes = [ burrow.base ];
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
  den.schema.host.includes = [ den.batteries.mutual-provider ];
}
