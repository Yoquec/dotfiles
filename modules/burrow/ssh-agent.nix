# https://nix-community.github.io/home-manager/options.xhtml#opt-services.ssh-agent.enable
{ ... }:
{
  burrow.ssh-agent.homeManager.services.ssh-agent.enable = true;
}
