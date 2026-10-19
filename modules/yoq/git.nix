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
          settings.settings = {
            pager.difftool = true;
            user = { inherit (user.identity) name email; };
          };
        };

        programs.eza.git = true;

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
