# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable
{ den, yoq, ... }:
{
  yoq.zsh = {
    includes = [
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

        programs.zsh = {
          enable = true;
          defaultKeymap = "viins";
          enableCompletion = true;
          autosuggestion.enable = true;
          fastSyntaxHighlighting.enable = true;
          dotDir = "${config.xdg.configHome}/zsh";

          initContent = ''
            # copilot-like autosuggest
            bindkey '^y' autosuggest-accept
          '';
        };

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
