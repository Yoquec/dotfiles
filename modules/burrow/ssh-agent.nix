# https://nix-community.github.io/home-manager/options.xhtml#opt-services.ssh-agent.enable
{ burrow, ... }:
{
  burrow.ssh-agent = {
    includes = [ burrow.keyring ];
    nixos.services.gnome.gcr-ssh-agent.enable = true;
  };
}
