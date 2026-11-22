# https://librewolf.net
{ burrow, ... }:
{
  yoq.browser = {
    includes = [ burrow.graphics ];

    homeManager =
      { host, lib, ... }:
      let
        isDarwin = lib.hasSuffix "-darwin" host.system;

        profiles.default = {
          id = 0;
          isDefault = true;

          settings = {
            # Enables sidebars
            "sidebar.revamp" = true;
            "sidebar.visibility" = "always-show";

            # built-in dark theme, no extension needed.
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          };

          search = {
            force = true;
            default = "DuckDuckGo (No AI)";
            engines."DuckDuckGo (No AI)" = {
              urls = [ { template = "https://noai.duckduckgo.com/?q={searchTerms}"; } ];
              icon = "https://duckduckgo.com/favicon.ico";
            };
          };
        };
      in
      if isDarwin then
        {
          stylix.targets.firefox.profileNames = [ "default" ];
          programs.firefox = {
            inherit profiles;
            enable = true;
          };
        }
      else
        {
          stylix.targets.librewolf.profileNames = [ "default" ];
          programs.librewolf = {
            inherit profiles;
            enable = true;
          };
        };
  };
}
