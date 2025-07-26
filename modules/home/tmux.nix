{
  lib,
  config,
  ...
}: {
  options.modules.tmux.enable = lib.mkEnableOption "Enable tmux";

  config = lib.mkIf config.modules.tmux.enable {
    programs.tmux.enable = true;
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
  };
}
