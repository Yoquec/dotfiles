{
  lib,
  config,
  ...
}:
let
  inherit (config.modules.writing) wiki;

  settings = {
    notebook = lib.mkIf wiki.enable {
      dir = wiki.directory;
    };
    group.daily = lib.mkIf wiki.enable {
      paths = [ "dailies" ];
      note.filename = "{{format-date now '%Y-%m-%d'}}";
      template = [ "daily_note.md" ];
    };
    note = {
      filename = "{{format-date now '%Y%m%d%H%M%S'}}";
    };
    format.markdown = {
      link-format = "[[{{metadata.id}}]]";
    };
  };
in
{
  options.modules.writing.zk.enable = lib.mkEnableOption "Enable zk";

  config = lib.mkIf config.modules.writing.zk.enable {
    programs.zk = {
      inherit settings;
      enable = true;
    };
  };
}
