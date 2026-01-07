{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config) home;
  inherit (config.modules.writing) taskwarrior;

  package = pkgs.taskwarrior3;
  # TODO: Condition on stylix?
  colorTheme = "dark-256";
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
    };
  };
}
