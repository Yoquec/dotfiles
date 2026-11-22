# Aspect holding everyoption related to identity
#   includes = [ (yoq.identity { name = "..."; email = "..."; }) ];
{ ... }:
{
  yoq.identity =
    { name, email }:
    {
      homeManager.programs.git.settings.user = { inherit name email; };
    };
}
