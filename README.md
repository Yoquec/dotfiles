<center>
  <a href="https://builtwithnix.org"><img src="https://builtwithnix.org/badge.svg" alt="Built with nix badge"></a>
  <a href="https://github.com/nix-community/home-manager"><img src="https://img.shields.io/badge/home manager-gray?&style=for-the-badge&logo=nixos"></a>
  <a href="https://github.com/yoquec/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/yoquec/dotfiles?colora=363a4f&colorb=b7bdf8&style=for-the-badge"></a>
  <a href="https://github.com/yoquec/dotfiles/commits/main"><img alt="github last commit" src="https://img.shields.io/github/last-commit/yoquec/dotfiles?color=98c379&style=for-the-badge"></a>
</center>

# Dotfiles 🚀

Repository containing my dotifles managed by [home-manager](https://github.com/nix-community/home-manager), except for my neovim config, which is consumed as a flake input and can be found [here](https://github.com/yoquec/nvim).

## Installing

```bash
# or git clone git@github.com:yoquec/dotfiles.git
git clone https://github.com/yoquec/dotfiles.git ~/.dotfiles
nix run --extra-experimental-features "nix-command flakes"\
  github:nix-community/home-manager -- \
  switch --extra-experimental-features "nix-command flakes" --flake ~/.dotfiles#<PROFILE>
```
