# `yoq.lib.jail`

Wraps [jail.nix](https://alexdav.id/projects/jail-nix/) and exposes `jail`
(the sandboxing function + `jail.combinators`) as a home-manager module arg.

Include it to use it:

```nix
den.aspects."${user}".includes = [ yoq.lib.jail ];
```

```nix
{ jail, pkgs, ... }:
{
  home.packages = [
    (jail "someapp" pkgs.someapp (with jail.combinators; [ tools.git confirm-mount-cwd ]))
  ];
}
```

Add your own combinator from anywhere (any aspect, any flake) by writing to
the `combinators` [quirk](https://den.denful.dev/guides/quirks/); it'll be folded
in automatically.

```nix
den.aspects.myThing = {
  includes = [ yoq.lib.jail ];
  combinators = { pkgs, ... }: [
    (builtin: { my-combinator = builtin.add-pkg-deps [ pkgs.foo ]; })
  ];
};
```
