# https://github.com/tmux/tmux
{
  yoq,
  lib,
  withSystem,
  ...
}:
{
  yoq.tmux =
    { host, user, ... }:
    withSystem host.system (
      { config, ... }:
      let
        perSystemCfg = config;
      in
      {
        includes = [
          yoq.theme
          yoq.fzf
          yoq.zk
        ];

        homeManager =
          { pkgs, config, ... }:
          let
            inherit (perSystemCfg.packages) tms tmswitch tmsproject;
          in
          {
            programs.tmux = {
              enable = true;
              clock24 = true;
              mouse = true;
              focusEvents = true;
              sensibleOnTop = true;
              baseIndex = 1;
              keyMode = "vi";
              terminal = "tmux-256color";
              shell = "${pkgs.zsh}/bin/zsh";

              extraConfig = ''
                set -sg escape-time 0

                # Keybinds
                bind-key H run-shell "${tms}/bin/tms '$HOME' 'Home 🏠'"
                ${lib.optionalString config.programs.zk.enable ''
                  bind-key W run-shell "${tms}/bin/tms '${config.programs.zk.settings.notebook.dir}' 'Notebook 📚'"
                ''}
                bind-key N popup -E "${tmsproject}/bin/tmsproject"
                bind-key Space popup -E "${tmswitch}/bin/tmswitch"
                bind b last-window
                bind h select-pane -L
                bind j select-pane -D
                bind k select-pane -U
                bind l select-pane -R

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
            };

            home.packages = [ tms ];

            home.shellAliases = {
              ta = "tmux attach";
              th = ''tmux new-session -s "Home 🏠" -c "$HOME"'';
              tw = lib.mkIf config.programs.zk.enable ''tmux new-session -s "Notebook 📚" -c "${config.programs.zk.settings.notebook.dir}"'';
            };
          };
      }
    );
}
