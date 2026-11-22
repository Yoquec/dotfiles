# https://web.whatsapp.com
{
  inputs,
  yoq,
  burrow,
  ...
}:
{
  burrow.whatsapp = {
    includes = [
      yoq.lib.jail
      burrow.graphics
    ];

    homeManager =
      {
        jail,
        pkgs,
        lib,
        config,
        ...
      }:
      {
        home.packages = [
          (inputs.self.lib.mkContainerizedWebapp
            {
              inherit pkgs lib jail;
              inherit (config.home) homeDirectory;
            }
            {
              name = "whatsapp";
              browser = pkgs.ungoogled-chromium;
              url = "https://web.whatsapp.com";
              description = "WhatsApp";
              extraCombinators = with jail.combinators; [
                notifications
                (try-readwrite "${config.home.homeDirectory}/Downloads")
              ];
            }
          )
        ];
      };
  };
}
