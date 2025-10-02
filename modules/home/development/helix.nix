{ lib, config, ... }:
let
  inherit (config.modules.development) helix;
  inherit (config.modules.writing) zk;

  settings = {
    theme = "base16_transparent";
    editor = {
      line-number = "relative";
      mouse = false;
      true-color = true;
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };

    keys.normal = {
      space = {
        F = ":format";
      };
    };
  };

  languages = {
    language = [
      lib.mkIf
      zk.enable
      ({
        name = "markdown";
        language-servers = [ "zk" ];
      })
    ];

    language-server = {
      zk = lib.mkIf zk.enable {
        command = "zk";
        args = [ "lsp" ];
      };
    };
  };
in
{
  options.modules.development.helix = {
    enable = lib.mkEnableOption "Enable helix";
  };

  config = lib.mkIf helix.enable {
    programs.helix = {
      enable = true;
      inherit settings languages;
    };
  };
}
