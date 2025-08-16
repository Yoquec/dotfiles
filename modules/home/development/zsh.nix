{
  lib,
  config,
  ...
}: {
  options.modules.development.zsh.enable = lib.mkEnableOption "Enable zsh";

  config = lib.mkIf config.modules.development.zsh.enable {
    programs.eza = {
      enable = true;
      icons = "auto";
      git = true;
      enableZshIntegration = true;
    };

    # See: https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable
    programs.zsh = {
      enable = true;
      defaultKeymap = "viins";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;

      shellAliases = {
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";

        # TODO: Should be moved to the X11 modules
        pbcopy = "xclip -sel c";
        pbpaste = "xclip -sel c -o";
      };

      initContent = ''
        # copilot-like autosuggest
        bindkey '^y' autosuggest-accept
      '';
    };
  };
}
