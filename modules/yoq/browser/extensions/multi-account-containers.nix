# https://github.com/mozilla/multi-account-containers
{ ... }:
{
  yoq.browser.homeManager =
    { firefoxAddons, ... }:
    {
      programs.librewolf.profiles.default.extensions.packages = [
        firefoxAddons.multi-account-containers
      ];
    };
}
