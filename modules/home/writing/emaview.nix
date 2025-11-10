{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.writing) emaview wiki;
in
{
  options.modules.writing.emaview = {
    enable = lib.mkEnableOption "Enable emaview";
  };

  config = lib.mkIf emaview.enable ({
    assertions = [
      {
        assertion = wiki.enable;
        message = "The wiki module (`modules.writing.wiki`) must be enabled";
      }
    ];

    home.packages = with pkgs; [
      pkgs.emaview
      emanote
    ];
  });
}
