{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.modules.writing) wiki;

  keyMode = "vi";
  terminal = "tmux-256color";

  tmuxPackages = {
    tms = (pkgs.writeShellScriptBin "tms" (builtins.readFile ../../../dotfiles/tmux/bin/tms));
    tmswitch = (
      pkgs.writeShellScriptBin "tmswitch" (builtins.readFile ../../../dotfiles/tmux/bin/tmswitch)
    );
    tmsproject = (
      pkgs.writeShellScriptBin "tmsproject" (builtins.readFile ../../../dotfiles/tmux/bin/tmsproject)
    );
    mktms = (
      pkgs.writeShellScriptBin "mktms" ''
        dir=$(pwd)
        dirname=$(basename $dir | tr _ " " | tr . _)
        ${tmuxPackages.tms}/bin/tms "$dir" "$dirname"
      ''
    );
  };

  extraConfig = ''
    set -sg escape-time 0

    # Keybinds
    bind-key H run-shell "${tmuxPackages.tms}/bin/tms '$HOME' 'Home 🏠'"
    bind-key N popup -E "${tmuxPackages.tmsproject}/bin/tmsproject"
    bind-key Space popup -E "${tmuxPackages.tmswitch}/bin/tmswitch"
    ${lib.optionalString wiki.enable ''
      bind-key W run-shell "${tmuxPackages.tms}/bin/tms '${wiki.directory}' 'Wiki 📚'"
    ''}

    # Colored undercurls
    set -ga terminal-overrides ',*256col*:Tc'
    set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
    set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

    # Status
    set -g status-left "[#S]"
    set -g status-left-length 100

    set -g status-right '%a %d-%m-%Y %H:%M'
    set -g status-right-length 20
    set -g window-status-format ' #I:#W#F '

    # Styles
    set -g status-style 'fg=default'
    set -g pane-border-style 'fg=colour223'
    set -g pane-active-border-style 'fg=colour2'
    set -g window-status-current-style 'fg=default bold'
    set -g window-status-current-format ' #[fg=colour9]#I#[fg=colour247]:#[fg=default]#W#F '
    set -g window-status-style 'fg=colour247'
    set -g window-status-bell-style 'fg=colour255 bg=colour1 bold'
  '';
in
{
  options.modules.development.tmux = {
    enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.modules.development.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      mouse = true;
      focusEvents = true;
      sensibleOnTop = true;
      baseIndex = 1;

      inherit keyMode;
      inherit terminal;
      inherit extraConfig;
    };

    home.packages = with tmuxPackages; [
      tms
      mktms
    ];

    programs.tmux.shell = lib.mkIf config.modules.development.zsh.enable "${pkgs.zsh}/bin/zsh";

    programs.zsh.shellAliases = lib.mkIf config.modules.development.zsh.enable {
      ta = "tmux attach";
      th = ''tmux new-session -s "Home 🏠" -c "$HOME"'';
      tw = lib.mkIf wiki.enable ''tmux new-session -s "Wiki 📚" -c "${wiki.directory}"'';
    };
  };
}
