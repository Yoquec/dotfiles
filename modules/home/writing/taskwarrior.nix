{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config) home theme;
  inherit (config.modules.writing) taskwarrior;
  inherit (config.modules.development) zsh;

  package = pkgs.taskwarrior3;
  colorTheme = if theme == "dark" then "dark-256" else "light-256";
  # TODO: Condition on nextcloud-client being installed
  dataLocation = "${home.homeDirectory}/Nextcloud/Tasks";
in
{
  options.modules.writing.taskwarrior = {
    enable = lib.mkEnableOption "Enable taskwarrior";
    dataLocation = lib.mkOption {
      type = lib.types.str;
      default = dataLocation;
      description = "Directory to hold task information";
    };
  };

  config = lib.mkIf taskwarrior.enable {
    programs.taskwarrior = {
      enable = true;
      inherit package colorTheme;
      inherit (taskwarrior) dataLocation;
      config = {
        default.command = "+UNBLOCKED priority.not:L next";
        uda.priority.values = [
          "H"
          "M"
          ""
          "L"
        ];
        urgency.uda.priority.L.coefficient = -2;
      };
    };

    programs.zsh.shellAliases = lib.mkIf zsh.enable {
      t = "task";
    };
  };
}
