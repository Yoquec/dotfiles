# https://git-scm.com
{ ... }:
{
  yoq.git =
    { user, ... }:
    {
      homeManager = {
        programs.git = {
          enable = true;
          lfs.enable = true;
          settings.pager.difftool = true;

          userName = user.identity.name;
          userEmail = user.identity.email;
        };

        programs.difftastic = {
          enable = true;
          git = {
            enable = true;
            diffToolMode = true;
          };
        };

        home.shellAliases = {
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
    };
}
