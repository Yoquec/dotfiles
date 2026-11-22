# https://mail.tutanota.com
{ inputs, yoq, ... }:
{
  burrow.tutanota = {
    includes = [ yoq.lib.jail ];

    homeManager =
      { jail, pkgs, lib, config, ... }:
      {
        home.packages = [
          (inputs.self.lib.mkContainerizedWebapp {
            inherit pkgs lib jail;
            inherit (config.home) homeDirectory;
          } {
            name = "tutanota";
            browser = pkgs.ungoogled-chromium;
            url = "https://mail.tutanota.com";
            description = "Tutanota";
            extraCombinators = with jail.combinators; [
              yubikey
              notifications
              (try-readwrite "${config.home.homeDirectory}/Downloads")
            ];
          })
        ];
      };
  };
}
