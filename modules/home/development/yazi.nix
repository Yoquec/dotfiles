{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config) xdg;
  inherit (pkgs.tmuxPackages) tms;
  inherit (config.modules.writing) wiki;
  inherit (config.modules.development)
    tmux
    lazygit
    yazi
    zsh
    ;

  settings = {
    open.prepend_rules = [
      {
        mime = "image/jpeg";
        use = [
          "image"
        ];
      }
      {
        mime = "image/png";
        use = [
          "image"
        ];
      }
    ];
    open.append_rules = [
      {
        name = "*.pdf";
        use = [
          "document"
        ];
      }
    ];
    opener = {
      image = [
        # TODO: Condition on feh being installed
        {
          run = ''feh $@'';
          desc = "Feh";
          for = "linux";
          orphan = true;
        }
      ];
      document = [
        # TODO: Condition on zathura being installed
        {
          run = ''zathura "$@"'';
          desc = "Zathura";
          for = "unix";
          orphan = true;
        }
        # TODO: Condition on okular being installed
        {
          run = ''okular "$@"'';
          desc = "Okular";
          for = "linux";
          orphan = true;
        }
      ];
    };
  };

  keymap = {
    mgr.prepend_keymap = [
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
        desc = "Seek down 5 units in the preview";
      }
      {
        on = [ "F" ];
        run = "filter --smart";
        desc = "Filter files";
      }
      {
        on = [ "X" ];
        run = ''shell 'chmod +x "$@"' --confirm '';
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
        run = ''shell $EDITOR --confirm --block'';
        desc = "Open the editor in current directory";
      }
      {
        on = [ "w" ];
        run = ''shell $SHELL --confirm --block '';
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
        run = "cd ${xdg.configHome}";
        desc = "Go to the config directory";
      }
      {
        on = [
          "g"
          ":"
        ];
        run = "cd ~/.dotfiles";
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
      # TODO: Conditionally add if nextcloud is enabled
      {
        on = [
          "g"
          "n"
        ];
        run = "cd ~/Nextcloud";
        desc = "Go to the Nextcloud directory";
      }
      (lib.mkIf wiki.enable {
        on = [
          "g"
          "W"
        ];
        run = ''cd "${wiki.directory}"'';
        desc = "Go to the wiki directory";
      })
      (lib.mkIf tmux.enable {
        on = [ "s" ];
        run = ''shell '${tms}/bin/tms "`pwd`"' --confirm --block'';
        desc = "Start a new tmux session in the current directory";
      })
      (lib.mkIf lazygit.enable {
        on = [ "<C-g>" ];
        run = ''shell lazygit --confirm --block'';
        desc = "Open lazygit in the current directory";
      })
    ];
  };
in
{
  options.modules.development.yazi.enable = lib.mkEnableOption "Enable yazi";

  config = lib.mkIf yazi.enable {
    programs.yazi = {
      enable = true;
      inherit keymap;
      inherit settings;
    };

    programs.zsh.shellAliases = lib.mkIf zsh.enable {
      yz = "yazi";
    };
  };
}
