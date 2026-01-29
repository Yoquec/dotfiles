{ ... }:
{
  flake.templates = {
    flake-parts = {
      path = ../../templates/flake-parts;
      description = "Flake parts (https://flake.parts) boostrap template";
    };
  };
}
