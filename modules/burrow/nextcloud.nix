# https://github.com/nextcloud/desktop
{ ... }:
{
  burrow.nextcloud.homeManager = {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
}
