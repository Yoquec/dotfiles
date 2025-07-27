{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.zsh.enable = lib.mkEnableOption "Enable zsh";

  config = lib.mkIf config.modules.zsh.enable {
    programs.eza = {
      enable = true;
      icons = true;
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

        yt = "yt-dlp --add-metadata -i";
        yta = "yt -x -f bestaudio/best";

        # TODO: Should be moved to the X11 modules
        pbcopy = "xclip -sel c";
        pbpaste = "xclip -sel c -o";
      };

      initContent = ''
        # powerlevel10k
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

        # copilot-like autosuggest
        bindkey '^y' autosuggest-accept

        # shell integrations
        [[ $(command -v direnv) ]] && eval "$(direnv hook zsh)"
        [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      '';
    };
  };
}
