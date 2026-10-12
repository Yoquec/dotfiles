# `yoq`

Public den namespace (`flake.denful.yoq`) with reusable aspects.

Other configurations may use declare the following in their `den.nix`:

```nix
`inputs.den.namespace "yoq" [ inputs.dotfiles ]`.
```

## Contents

- `darwin.nix` — `yoq.darwin`, base nix-darwin system defaults.
- `aerospace.nix` — `yoq.aerospace`, AeroSpace window manager via `services.aerospace`. Included by `yoq.darwin`.
- `theme.nix` — `yoq.theme`, system-wide theming (currently implemented via [stylix](https://github.com/nix-community/stylix)). Not included anywhere yet; add `includes = [ yoq.theme ]` to a home-manager-bearing aspect to use it.
