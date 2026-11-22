# https://github.com/swaywm/swayidle
{ ... }:
{
  burrow.sway.homeManager =
    { lib, config, ... }:
    let
      swaylock = lib.getExe config.programs.swaylock.package;
    in
    {
      services.swayidle = {
        enable = true;
        events = {
          before-sleep = "${swaylock} -fF";
          lock = "${swaylock} -fF";
        };
        timeouts = [
          {
            timeout = 600;
            command = "${swaylock} -fF";
          }
        ];
      };
    };
}
