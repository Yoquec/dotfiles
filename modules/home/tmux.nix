{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.tmux = {
    enable = lib.mkEnableOption "Enable tmux";
    installBinary = lib.mkEnableOption "Install tmux binary with nix";
  };

  config = lib.mkIf config.modules.tmux.enable {
    # NOTE: Don't install tmux through home-manager due to variation configuration file handling.
    home.packages = lib.mkIf config.modules.tmux.installBinary (with pkgs; [
      tmux
    ]);

    home.file = {
      ".tmux.conf".source = ../../dotfiles/tmux/.tmux.conf;
      ".local/bin/tms" = {
        executable = true;
        source = ../../dotfiles/tmux/bin/tms;
      };
      ".local/bin/tmswitch" = {
        executable = true;
        source = ../../dotfiles/tmux/bin/tmswitch;
      };
      ".local/bin/tmsproject" = {
        executable = true;
        source = ../../dotfiles/tmux/bin/tmsproject;
      };
    };

    programs.zsh.shellAliases = lib.mkIf config.modules.zsh.enable {
      ta = "tmux attach";
      th = ''tmux new-session -s "Home 🏠" -c "$HOME"'';
      tw = ''tmux new-session -s "Wiki 📚" -c "$WIKI_HOME"'';
    };
  };
}
