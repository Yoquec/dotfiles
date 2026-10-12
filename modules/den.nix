{ inputs, den, ... }:
{
  imports = [
    (inputs.den.namespace "yoq" true) # shared/reusable aspects
    (inputs.den.namespace "burrow" false) # personal, not exported
  ];

  config._module.args.__findFile = den.lib.__findFile;
}
