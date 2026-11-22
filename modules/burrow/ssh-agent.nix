# https://nix-community.github.io/home-manager/options.xhtml#opt-services.ssh-agent.enable
{ ... }:
{
  burrow.ssh-agent.nixos.services.gnome.gcr-ssh-agent.enable = true;
}
