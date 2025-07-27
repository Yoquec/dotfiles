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
        yt = "yt-dlp --add-metadata -i";
        yta = "yt -x -f bestaudio/best";

        yz = "yazi";
        lg = "lazygit";

        awsc = "aws --cli-auto-prompt";

        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";

        ta = "tmux attach";
        th = ''tmux new-session -s "Home 🏠" -c "$HOME"'';
        tw = ''tmux new-session -s "Wiki 📚" -c "$WIKI_HOME"'';

        pbcopy = "xclip -sel c";
        pbpaste = "xclip -sel c -o";

        pom = "pomodoro";

        ga = "git add";
        gb = "git branch";
        gc = "git commit";
        gd = "git diff";
        gsw = "git switch";
        gst = "git status";
        gwt = "git worktree";
        glo = "git log --oneline";
      };

      initContent = ''
        # powerlevel10k
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

        # copilot-like autosuggest
        bindkey '^y' autosuggest-accept

        # shell integrations
        [[ $(command -v mise) ]] && eval "$(mise activate zsh)"
        [[ $(command -v fzf) ]] && eval "$(fzf --zsh)"
        [[ $(command -v direnv) ]] && eval "$(direnv hook zsh)"
        [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      '';
    };
  };
}
