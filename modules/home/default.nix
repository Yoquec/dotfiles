# A module that automatically imports everything else in the current directory.
# See: https://github.com/juspay/nixos-unified-template/blob/main/modules/home/default.nix
{
  lib,
  ...
}: {
  imports = with builtins;
    map
    (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  zsh.enable = lib.mkDefault true;
}
