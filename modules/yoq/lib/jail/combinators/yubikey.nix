# see: https://github.com/igo95862/bubblejail/issues/26
{ ... }:
{
  yoq.lib.jail.combinators = _: [
    (builtin: rec {
      try-dev-bind =
        from: to: builtin.unsafe-add-raw-args "--dev-bind-try ${builtin.escape from} ${builtin.escape to}";

      runtime-bind-hidraw = builtin.include-once "runtime-bind-hidraw" (
        builtin.add-runtime ''
          for dev in /dev/hidraw*; do
              RUNTIME_ARGS+=(--dev-bind "$dev" "$dev")
          done
        ''
      );

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
    })
  ];
}
