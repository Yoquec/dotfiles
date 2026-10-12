# https://github.com/zk-org/zk
{ burrow, ... }:
{
  yoq.zk = {
    includes = [ burrow.nixvim ];

    homeManager =
      { config, lib, ... }:
      let
        # zk defines a sensible default for the notebook directory
        # that can be overridden by other modules (e.g. nextcloud)
        defaultNotebookDir = "${config.home.homeDirectory}/Notebook";
      in
      {
        programs.zk = {
          enable = true;
          settings = {
            notebook.dir = lib.mkDefault defaultNotebookDir;
            note = {
              filename = "{{format-date now '%Y%m%d%H%M%S'}}";
              template = "default.md";
            };
            format.markdown.link-format = "[[{{metadata.id}}|{{title}}]]";
          };
        };

        home.file."${config.xdg.configHome}/zk/templates/default.md".source = ./default.md;

        # notebook.dir may not exist yet on a fresh machine; pre-materialize
        # it so `zk` has somewhere to write on first use.
        # See: https://home-manager.dev/manual/26.05/options.xhtml#opt-home.activation
        home.activation.createZkNotebookDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run mkdir -p ${lib.escapeShellArg config.programs.zk.settings.notebook.dir}
        '';
      };
  };
}
