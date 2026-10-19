{ lib, burrow, ... }:
{
  den.default.includes = [ burrow.base ];
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
