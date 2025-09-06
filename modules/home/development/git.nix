{
  lib,
  config,
  ...
}:
let
  inherit (config) identity;
in
{
  options.modules.development.git.enable = lib.mkEnableOption "Enable git";

  config = lib.mkIf config.modules.development.git.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      difftastic = {
        enable = true;
        enableAsDifftool = true;
      };
      extraConfig = {
        pager = {
          difftool = true;
        };
        user = {
          name = identity.fullname;
          email = identity.username;
        };
      };
    };

    programs.zsh.shellAliases = lib.mkIf config.modules.development.zsh.enable {
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
