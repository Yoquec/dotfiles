# https://github.com/sxyazi/yazi
{ yoq, ... }:
{
  yoq.yazi = {
    includes = [ yoq.theme ];

    homeManager =
      { pkgs, config, ... }:
      {
        home.packages = [
          pkgs.feh
          pkgs.zathura
        ];

        programs.yazi = {
          enable = true;
          shellWrapperName = "yy";

          # https://github.com/ndtoan96/ouch.yazi/blob/main/README.md
          extraPackages = [ pkgs.ouch ];
          plugins.ouch = pkgs.yaziPlugins.ouch;

          settings = {
            plugin.prepend_previewers = [
              {
                mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
                run = "ouch";
              }
            ];
            opener.extract = [
              {
                run = ''ouch d -y "$@"'';
                desc = "Extract here with ouch";
                for = "unix";
              }
            ];
          };

          keymap.mgr.prepend_keymap = [
            {
              on = [ "C" ];
              run = "plugin ouch";
              desc = "Compress with ouch";
            }
            {
              on = [ "<C-b>" ];
              run = "seek -5";
              desc = "Seek up 5 units in the preview";
            }
            {
              on = [ "<C-f>" ];
              run = "seek 5";
              desc = "Seek down 5 units in the preview";
            }
            {
              on = [ "f" ];
              run = "cd --interactive";
              desc = "Jump to a directory (interactive)";
            }
            {
              on = [ "F" ];
              run = "filter --smart";
              desc = "Filter files";
            }
            {
              on = [ "X" ];
              run = ''shell 'chmod +x "$@"' --confirm'';
              desc = "Make selected files executable";
            }
            {
              on = [ "i" ];
              run = ''shell '$PAGER "$@" --paging=always' --confirm --block'';
              desc = "Open files in the pager";
            }
            {
              on = [ "e" ];
              run = ''shell '$EDITOR "$@"' --confirm --block'';
              desc = "Open the selected file(s) in the editor";
            }
            {
              on = [ "E" ];
              run = "shell $EDITOR --confirm --block";
              desc = "Open the editor in current directory";
            }
            {
              on = [ "w" ];
              run = "shell $SHELL --confirm --block";
              desc = "Start terminal session";
            }
            {
              on = [ "%" ];
              run = "create";
              desc = "Create a file (ends with / for directories)";
            }
            {
              on = [ "D" ];
              run = "create --dir";
              desc = "Create a directory";
            }
            {
              on = [
                "g"
                "."
              ];
              run = "cd ${config.xdg.configHome}";
              desc = "Go to the config directory";
            }
            {
              on = [
                "g"
                ":"
              ];
              run = "cd ${config.home.homeDirectory}/workplace/dotfiles";
              desc = "Go to the dotfiles directory";
            }
            {
              on = [
                "g"
                "d"
              ];
              run = "cd ~/Documents";
              desc = "Go to the Documents directory";
            }
            {
              on = [
                "g"
                "D"
              ];
              run = "cd ~/Downloads";
              desc = "Go to the Downloads directory";
            }
            {
              on = [
                "g"
                "p"
              ];
              run = "cd ~/Pictures";
              desc = "Go to the Pictures directory";
            }
            {
              on = [
                "g"
                "w"
              ];
              run = "cd ~/workplace";
              desc = "Go to the workplace directory";
            }
            {
              on = [
                "g"
                "m"
              ];
              run = "cd ~/Music";
              desc = "Go to the Music directory";
            }
            {
              on = [
                "g"
                "l"
              ];
              run = "cd ~/.local";
              desc = "Go to the .local directory";
            }
            {
              on = [
                "g"
                "s"
              ];
              run = "cd ~/.local/bin";
              desc = "Go to the local scripts directory";
            }
          ];
        };

        home.shellAliases = {
          yz = "yazi";
        };
      };
  };
}
