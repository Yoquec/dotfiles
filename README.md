<p align="center">
  <a href="https://builtwithnix.org"><img src="https://builtwithnix.org/badge.svg" alt="Built with nix badge"></a>
  <a href="https://github.com/nix-community/home-manager"><img src="https://img.shields.io/badge/home manager-gray?&style=for-the-badge&logo=nixos"></a>
  <a href="https://github.com/yoquec/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/yoquec/dotfiles?colora=363a4f&colorb=b7bdf8&style=for-the-badge"></a>
  <a href="https://github.com/yoquec/dotfiles/commits/main"><img alt="github last commit" src="https://img.shields.io/github/last-commit/yoquec/dotfiles?color=98c379&style=for-the-badge"></a>
</p>

# Dotfiles 🚀

Repository containing my dotifles managed by [home-manager](https://github.com/nix-community/home-manager) structured as per [`nixos-unified`](https://nixos-unified.org). It does not contain my neovim config, which instead is consumed as a flake input and can be found [here](https://github.com/yoquec/nvim).
Hopefully in the near future, when I have time, this also starts containing both NixOS and `nix-darwin` modules.

## Structure

```
.
├── configurations/         # Host-specific configurations
│   └── home/               # Standalone home-manager hosts
├── modules/                # Reusable modules
│   ├── home/               # Shared home-manager modules
│   ├── shared/             # Shared NixOS+Darwin modules
│   └── flake/              # Flake-level configuration
├── overlays/               # Nixpkgs overlays
├── templates/              # Flake provided templates
├── packages/               # Packaged scripts
└── secrets/                # Encrypted secrets (agenix-rekey)
```

Special thank you to these great repos for their inspiration:

- https://github.com/srid/nixos-config
- https://github.com/lovesegfault/nix-config

## System config ⚙️

```bash
# or git clone git@github.com:yoquec/dotfiles.git
git clone https://github.com/yoquec/dotfiles.git ~/.dotfiles
nix run --extra-experimental-features "nix-command flakes"\
  github:nix-community/home-manager -- \
  switch --extra-experimental-features "nix-command flakes" --flake ~/.dotfiles#<PROFILE>
```

### Theming 🎨

`homeConfigurations` allow for light/dark theme configuration through the `sharedModules.theme` module. It defaults to the value `"dark"`, but can be overriden via the `THEME` environment variable.

```sh
# To activate the profile in light theme
THEME=light home-manager switch --flake .#yoquec --impure
```

## Development containers

To spin up development containers, pull the [NixOS](https://hub.docker.com/r/nixos/nix) container image and run the home manager configuration

```sh
podman container run -it --network host --name devcontainer docker.io/nixos/nix:latest

# Once inside the devcontainer
export NIX_CONFIG='extra-experimental-features = nix-command flakes'
nix profile list --json | nix run nixpkgs#jq -- -r '.elements | keys[]' | grep -v -E "nix|nss-cacert" | xargs nix profile remove
nix run github:nix-community/home-manager -- switch --flake github:yoquec/dotfiles#devcontainer
```
