{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "Enable git";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      difftastic = {
        enable = true;
        enableAsDifftool = true;
      };
      extraConfig = {
        pager = {difftool = true;};
        user = {
          name = "Alvaro Viejo";
          email = "alvaro.viejo@yoquec.com";
        };
      };
    };
  };
}
