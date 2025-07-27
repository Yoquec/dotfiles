{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "Enable git";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      difftastic = {
        enable = true;
        enableAsDifftool = true;
      };
      extraConfig = {
        pager = {difftool = true;};
        user = {
          name = config.identity.fullname;
          email = config.identity.username;
        };
      };
    };

    programs.zsh.shellAliases = lib.mkIf config.modules.zsh.enable {
      ga = "git add";
      gb = "git branch";
      gc = "git commit";
      gd = "git diff";
      gsw = "git switch";
      gst = "git status";
      gwt = "git worktree";
      glo = "git log --oneline";
    };
  };
}
