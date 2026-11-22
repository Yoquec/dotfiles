{ lib, ... }:
{
  den.schema.user =
    { config, ... }:
    {
      options.identity = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "Name of the user";
        };
        email = lib.mkOption {
          type = lib.types.str;
          description = "Email for the user";
        };
      };

      config.identity = lib.mkIf (config.userName == "yoquec") (
        lib.mkDefault {
          name = "Alvaro Viejo";
          email = "alvaro.viejo@yoquec.com";
        }
      );
    };
}
