# Safer version of mount-cwd that asks for confirmation first.
{ ... }:
{
  yoq.lib.jail.combinators =
    { pkgs, lib, ... }:
    [
      (builtin: {
        confirm-mount-cwd = builtin.compose [
          (builtin.add-runtime ''
            query="Allow $0 to access $(pwd)?"
            LINES=$(stty size | cut -d " " -f1)
            COLUMNS=$(stty size | cut -d " " -f2)
            vpad=$((LINES/2 - LINES/20))
            hpad=$((COLUMNS/2 - ''${#query}/2 - 1))
            (( vpad < 0 )) && vpad=0
            (( hpad < 0 )) && hpad=0
            ${lib.getExe pkgs.gum} confirm --padding "$vpad $hpad" "$query" || exit 1
          '')
          builtin.mount-cwd
        ];
      })
    ];
}
