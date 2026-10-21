# https://github.com/jesseduffield/lazygit
{ yoq, ... }:
{
  yoq.lazygit = {
    includes = [
      yoq.git
      yoq.theme
    ];

    homeManager = {
      programs.lazygit.enable = true;
      home.shellAliases = {
        lg = "lazygit";
      };

      programs.yazi.keymap.mgr.prepend_keymap = [
        {
          on = [ "<C-g>" ];
          run = "shell lazygit --confirm --block";
          desc = "Open lazygit in the current directory";
        }
      ];
    };
  };
}
