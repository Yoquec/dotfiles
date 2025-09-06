{
  lib,
  config,
  ...
}:
{
  options.modules.writing.wiki = {
    enable = lib.mkEnableOption "Enable wiki";

    directory = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Directory were the wiki lives";
    };
  };

  config = lib.mkIf config.modules.writing.enable (
    let
      inherit (config.modules.writing.wiki) directory;
    in
    {
      assertions = [
        {
          assertion = directory != "";
          message = "A directory must be configured if the wiki is enabled";
        }
      ];

      home.sessionVariables = {
        WIKI_HOME = directory;
      };
    }
  );
}
