# https://github.com/swaywm/sway + https://github.com/gabm/satty
{ ... }:
{
  burrow.sway.homeManager =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      inherit (config.wayland.windowManager.sway.config) modifier;

      screenshot = pkgs.writeShellApplication {
        name = "screenshot";
        runtimeInputs = with pkgs; [
          grim
          slurp
          satty
        ];
        text = ''
          region=$(slurp) || exit 0
          grim -g "$region" - | satty --filename -
        '';
      };
    in
    {
      wayland.windowManager.sway.config.keybindings."${modifier}+Shift+s" =
        "exec ${lib.getExe screenshot}";
    };
}
