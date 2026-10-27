{ inputs, den, ... }:
{
  imports = [
    (inputs.den.namespace "yoq" true) # shared/reusable aspects
    (inputs.den.namespace "burrow" false) # personal, not exported
  ];

  flake-file.inputs.self.lfs = true;
  _module.args.__findFile = den.lib.__findFile;

  # expected consuming architectures of the flake
  den.systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
}
