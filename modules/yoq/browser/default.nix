# https://librewolf.net
{ yoq, burrow, ... }:
{
  yoq.browser = {
    includes = [
      yoq.theme
      burrow.graphics
    ];

    homeManager =
      {
        host,
        lib,
        config,
        ...
      }:
      let
        isDarwin = lib.hasSuffix "-darwin" host.system;

        profiles.default = {
          id = 0;
          isDefault = true;

          settings = {
            # Enables sidebars, vertical tabs.
            "sidebar.revamp" = true;
            "sidebar.visibility" = "always-show";
            "sidebar.verticalTabs" = true;

            "browser.nova.enabled" = false;

            "extensions.activeThemeID" =
              if config.yoq.theme.polarity == "dark" then
                "firefox-compact-dark@mozilla.org"
              else
                "firefox-compact-light@mozilla.org";
          };

          containersForce = true;
          containers.AI = {
            id = 1;
            icon = "fingerprint";
            color = "yellow";
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

        # Sites kept out of "clear history"/cookie purges.`.
        policies.Cookies.Allow = [
          "https://perplexity.ai"
          "https://github.com"
        ];
      in
      if isDarwin then
        {
          stylix.targets.firefox.profileNames = [ "default" ];
          programs.firefox = {
            inherit profiles policies;
            enable = true;
          };
        }
      else
        {
          stylix.targets.librewolf.profileNames = [ "default" ];
          programs.librewolf = {
            inherit profiles policies;
            enable = true;
          };
        };
  };
}
