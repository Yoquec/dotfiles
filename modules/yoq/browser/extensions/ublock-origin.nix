{ ... }:
{
  yoq.browser.homeManager =
    { firefoxAddons, ... }:
    {
      programs.librewolf.profiles.default.extensions.packages = [ firefoxAddons.ublock-origin ];
    };
}
