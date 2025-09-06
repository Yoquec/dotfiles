{
  lib,
  config,
  ...
}:
let
  settings.theme = {
    background = "none";
    title = "green";
    playing = "green";
    playing_selected = "light green";
    highlight_bg = "#484848";
    error = "light white";
    error_bg = "red";
    statusbar = "black";
    statusbar_progress = "green";
    statusbar_bg = "green";
    search_match = "light red";
  };
in
{
  options.modules.media.ncspot = {
    enable = lib.mkEnableOption "Install and manage ncspot through home-manager";
  };

  config = lib.mkIf config.modules.media.ncspot.enable {
    programs.ncspot = {
      enable = true;
      inherit settings;
    };
  };
}
