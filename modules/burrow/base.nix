# minimal foundational defaults every entity needs to evaluate at all.
# activated globally via den.default.includes in modules/defaults.nix, so
# nothing needs to opt into this explicitly.
{ ... }:
{
  burrow.base = {
    nixos.system.stateVersion = "26.05";
    # see https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
    darwin.system.stateVersion = 7;
    homeManager.home.stateVersion = "26.05";
  };
}
