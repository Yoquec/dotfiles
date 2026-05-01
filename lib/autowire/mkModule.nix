{ lib, ... }:
{
  path,
  name,
  parents ? [ ],
}:
let
  # modname -> modfile attrset
  modulesFromPath =
    path:
    lib.mapAttrs' (mod: _: lib.nameValuePair (lib.removeSuffix ".nix" mod) (path + "/${mod}")) (
      lib.filterAttrs (k: v: (lib.hasSuffix ".nix" k) && k != "default.nix" && v == "regular") (
        builtins.readDir path
      )
    );

  mkHome =
    path:
    let
      modules = modulesFromPath path;
      components = parents ++ [ name ];

      configValues =
        let
          enable = lib.mkDefault false;
        in
        {
          inherit enable;
        }
        // lib.mapAttrs' (mod: _: lib.nameValuePair mod ({ enable = lib.mkDefault true; })) modules;

      configAttrset = lib.setAttrByPath components configValues;
      optionsAttrset = lib.setAttrByPath (components ++ [ "enable" ]) (
        let
          name = lib.strings.concatStringsSep " " (lib.lists.reverseList components);
        in
        lib.mkEnableOption "Enable ${name} module"
      );
    in
    {
      imports = lib.attrsets.attrValues modules;
      config = {
        modules = configAttrset;
      };
      options = {
        modules = optionsAttrset;
      };
    };
in
lib.throwIfNot (builtins.pathExists path) "Path must exist for autowiring" mkHome path
