# https://github.com/zk-org/zk
{ burrow, withSystem, ... }:
let
  mkHomeManager =
    systemConfig:
    { config, lib, ... }:
    let
      # zk defines a sensible default for the notebook directory
      # that can be overridden by other modules (e.g. nextcloud)
      defaultNotebookDir = "${config.home.homeDirectory}/Notebook";
      inherit (systemConfig.packages) tms;
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

      programs.yazi.keymap = {
        mgr.prepend_keymap = [
          {
            on = [
              "g"
              "W"
            ];
            run = ''cd "${config.programs.zk.settings.notebook.dir}"'';
            desc = "Go to the notebook directory";
          }
        ];
      };

      home.file."${config.xdg.configHome}/zk/templates/default.md".source = ./default.md;

      programs.tmux.extraConfig = ''
        bind-key W run-shell "${lib.getExe tms} '${config.programs.zk.settings.notebook.dir}' 'Notebook 📚'"
      '';

      home.shellAliases.tw = ''tmux new-session -s "Notebook 📚" -c "${config.programs.zk.settings.notebook.dir}"'';

      # notebook.dir may not exist yet on a fresh machine; pre-materialize
      # it so `zk` has somewhere to write on first use.
      # See: https://home-manager.dev/manual/26.05/options.xhtml#opt-home.activation
      home.activation.createZkNotebookDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p ${lib.escapeShellArg config.programs.zk.settings.notebook.dir}
      '';
    };
in
{
  yoq.zk = rec {
    includes = [
      burrow.nixvim
      provides.host-bound
      provides.standalone
    ];

    provides.host-bound =
      { host, ... }:
      withSystem host.system (
        { config, ... }:
        {
          homeManager = mkHomeManager config;
        }
      );

    provides.standalone =
      { home, ... }:
      withSystem home.system (
        { config, ... }:
        {
          homeManager = mkHomeManager config;
        }
      );
  };
}
