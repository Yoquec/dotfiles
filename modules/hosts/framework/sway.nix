{ ... }:
{
  den.aspects.framework.provides.to-users.homeManager = { pkgs, lib, ... }: {
    wayland.windowManager.sway.config = {
      output."eDP-1".scale = "1.33";
      keybindings = {
        "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} -d amdgpu_bl1 set 5%-";
        "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} -d amdgpu_bl1 set 5%+";
      };
    };
  };
}
