# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable
{ den, yoq, ... }:
{
  yoq.zsh = {
    includes = [
      yoq.theme
      yoq.starship
      (den.batteries.user-shell "zsh")
    ];

    homeManager =
      { config, lib, ... }:
      {
        programs.eza = {
          enable = true;
          icons = "auto";
        };

        programs.fzf.enable = true;

        programs.zsh = {
          enable = true;
          defaultKeymap = "viins";
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          dotDir = "${config.xdg.configHome}/zsh";

          initContent = ''
            # copilot-like autosuggest
            bindkey '^y' autosuggest-accept
          '';
        };

        programs.tmux.shell = "${lib.getExe config.programs.zsh.package}";

        home.shellAliases = {
          rm = "rm -i";
          cp = "cp -i";
          mv = "mv -i";
        };

        home.shell.enableZshIntegration = true;

        home.sessionVariables = {
          SHELL = "${lib.getExe config.programs.zsh.package}";
        };
      };
  };
}
