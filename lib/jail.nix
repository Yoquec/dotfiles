# Custom configuration (e.g. combinators) for jail.nix
# See: https://alexdav.id/projects/jail-nix/advanced-configuration/#additionalcombinators

{ pkgs, ... }:
{
  combinators = builtin: rec {
    tools = {
      git = (builtin.add-pkg-deps [ pkgs.git ]);
      bash = builtin.compose (
        let
          shell = pkgs.bashNonInteractive;
        in
        [
          (builtin.set-env "SHELL" "${shell}/bin/bash")
          (builtin.add-pkg-deps [
            shell
            pkgs.coreutils
            pkgs.gnugrep
            pkgs.gnused
            pkgs.findutils
            pkgs.curl
            pkgs.wget
            pkgs.which
          ])
        ]
      );
    };

    # Safer version of mount-cwd to confirm the mount
    confirm-mount-cwd = builtin.compose [
      (builtin.add-runtime ''
        query="Allow $0 to access $(pwd)?"
        LINES=$(stty size | cut -d " " -f1)
        COLUMNS=$(stty size | cut -d " " -f2)
        vpad=$((LINES/2 - LINES/20))
        hpad=$((COLUMNS/2 - ''${#query}/2 - 1))
        (( vpad < 0 )) && vpad=0
        (( hpad < 0 )) && hpad=0
        ${pkgs.gum}/bin/gum confirm --padding "$vpad $hpad" "$query" || exit 1
      '')
      builtin.mount-cwd
    ];

    read-env-file =
      name: path:
      builtin.add-runtime ''
        RUNTIME_ARGS+=(--setenv ${name} "$(cat "${path}")")
      '';

    try-dev-bind =
      from: to: builtin.unsafe-add-raw-args "--dev-bind-try ${builtin.escape from} ${builtin.escape to}";

    runtime-bind-hidraw = builtin.include-once "runtime-bind-hidraw" (
      builtin.add-runtime ''
        for dev in /dev/hidraw*; do
            RUNTIME_ARGS+=(--dev-bind "$dev" "$dev")
        done
      ''
    );

    # see: https://github.com/igo95862/bubblejail/issues/26
    yubikey = builtin.compose (
      with builtin;
      [
        runtime-bind-hidraw
        (try-dev-bind "/dev/usb" "/dev/usb")

        (ro-bind "/run/udev" "/run/udev")
        (ro-bind "/sys/devices" "/sys/devices")
        (ro-bind "/sys/class" "/sys/class")
      ]
    );
  };
}
