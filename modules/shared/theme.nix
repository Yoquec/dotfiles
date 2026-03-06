{ lib, ... }:

let
  default = "dark";
in

{
  options = {
    theme = lib.mkOption {
      type = lib.types.enum [
        "dark"
        "light"
      ];
      description = "System theme for apps and programs";
    };

  };

  config.theme =
    let
      themeEnv = builtins.getEnv "THEME";
      theme =
        if themeEnv == "" then
          default
        else
          (if themeEnv != "dark" && themeEnv != "light" then default else themeEnv);
    in
    lib.mkDefault theme;
}
