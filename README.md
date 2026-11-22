<p align="center">
  <a href="https://builtwithnix.org"><img src="https://builtwithnix.org/badge.svg" alt="Built with nix badge"></a>
  <a href="https://github.com/nix-community/home-manager"><img src="https://img.shields.io/badge/home manager-gray?&style=for-the-badge&logo=nixos"></a>
  <a href="https://github.com/yoquec/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/yoquec/dotfiles?colora=363a4f&colorb=b7bdf8&style=for-the-badge"></a>
  <a href="https://github.com/yoquec/dotfiles/commits/main"><img alt="github last commit" src="https://img.shields.io/github/last-commit/yoquec/dotfiles?color=98c379&style=for-the-badge"></a>
</p>

# Dotfiles 🚀

My personal NixOS configuration built on top of [den](https://den.denful.dev), an aspect-oriented Nix
framework.

## Structure

```
.
├── modules/
│   ├── burrow/          # private aspects, specific to my own machines
│   ├── yoq/             # public, reusable aspects (flake.denful.yoq)
│   ├── hosts/           # per-host aspects (disko, hardware, install docs)
│   ├── hosts.nix        # host/user declarations
│   └── vm.nix           # `nix run .#vm`
├── templates/           # flake templates for bootstrapping new machines
├── secrets/             # agenix-rekey encrypted secrets
└── assets/              # wallpapers, etc.
```

Special thank you to this great repo for its inspiration:

- https://github.com/vic/vix

### Theming 🎨

`yoq.theme` allows for light/dark theme configuration through the
`yoq.theme.polarity` option. It defaults to `"dark"`, but can be overridden
via the `THEME` environment variable.

```sh
# To activate the profile in light theme
THEME=light nix run .#yoquec -- switch --impure
```
