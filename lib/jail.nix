# Custom configuration (e.g. combinators) for jail.nix
# See: https://alexdav.id/projects/jail-nix/advanced-configuration/#additionalcombinators

{ pkgs, ... }:
{
  combinators = builtin: {
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

    unsafe-gui = builtin.compose (
      with builtin;
      [
        # see: https://git.sr.ht/~alexdavid/jail.nix/tree/404e7da9da5ab9aa643666682b2ba1312fa5fbe8/lib/combinators/gui.nix#L26
        # X11 and DBus
        unsafe-x11
        unsafe-dbus
        (fwd-env "XAUTHORITY")
        (readonly-paths-from-var "XAUTHORITY" " ")
        (readonly "/run/dbus/system_bus_socket")
        (add-runtime "mkdir -p ~/.config/dconf")
        (readonly (noescape "~/.config/dconf"))

        # Fonts
        (runtime-deep-ro-bind (noescape "/etc/fonts"))
        (fwd-env "XDG_RUNTIME_DIR")
        (fwd-env "XDG_DATA_DIRS")
        (readonly-paths-from-var "XDG_DATA_DIRS" ":")

        # Cursor
        (try-fwd-env "XCURSOR_THEME")
        (try-fwd-env "XCURSOR_PATH")
        (try-fwd-env "XCURSOR_SIZE")
        (readonly-paths-from-var "XCURSOR_PATH" " ")

        # network
        time-zone
        (share-ns "net")
        (runtime-deep-ro-bind "/etc/hosts")
        (runtime-deep-ro-bind "/etc/nsswitch.conf")
        (runtime-deep-ro-bind "/etc/resolv.conf")
        (runtime-deep-ro-bind "/etc/ssl")
        (try-readonly "/run/systemd/resolve")
        (runtime-deep-ro-bind "/etc/hostname")
      ]
    );
  };
}
