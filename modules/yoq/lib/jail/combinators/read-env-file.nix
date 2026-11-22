{ ... }:
{
  yoq.lib.jail.combinators = _: [
    (builtin: {
      read-env-file =
        name: path:
        builtin.add-runtime ''
          RUNTIME_ARGS+=(--setenv ${name} "$(cat "${path}")")
        '';
    })
  ];
}
