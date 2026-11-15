# https://github.com/tridactyl/tridactyl
#
# tridactyl-native is required for the rc file (~/.config/tridactyl/tridactylrc)
# to be read from disk; without it, settings only persist in extension storage.
{ ... }:
{
  yoq.browser.homeManager =
    {
      host,
      lib,
      pkgs,
      firefoxAddons,
      ...
    }:
    if lib.hasSuffix "-darwin" host.system then
      {
        programs.firefox = {
          nativeMessagingHosts = [ pkgs.tridactyl-native ];
          profiles.default.extensions.packages = [ firefoxAddons.tridactyl ];
        };
      }
    else
      {
        programs.librewolf = {
          nativeMessagingHosts = [ pkgs.tridactyl-native ];
          profiles.default.extensions.packages = [ firefoxAddons.tridactyl ];
        };
      }
      // {
        xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
      };
}
