# https://den.denful.dev/guides/namespaces/
{ inputs, ... }:
{
  imports = [ (inputs.den.namespace "yoq" [ inputs.yoquec-dotfiles ]) ];
}
