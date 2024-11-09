<p align="center">
    <a href="https://github.com/yoquec/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/yoquec/dotfiles?colora=363a4f&colorb=b7bdf8&style=for-the-badge"></a>
    <a href="https://github.com/yoquec/dotfiles/commits/main"><img alt="github last commit" src="https://img.shields.io/github/last-commit/yoquec/dotfiles?color=98c379&style=for-the-badge"></a>
    <a href="https://www.gnu.org/software/stow/"><img src="https://img.shields.io/badge/stow-gray?&style=for-the-badge&logo=gnu"></a>
</p>

# Dotfiles

My personal dotfiles repository managed by [GNU stow](https://www.gnu.org/software/stow/). 

## Installing configurations

1. Download GNU Stow
2. Clone the repo into your local computer
  ```bash
  git clone https://github.com/yoquec/dotfiles $HOME/.local/share/dotfiles
  ```
3. Install the common configs using stow
  ```bash
  cd $HOME/.local/share/dotfiles/common && stow -t $HOME *
  ```
4. Install the computer-specific configs
  ```bash
  cd $HOME/.local/share/dotfiles/{desktop|laptop|framework} && stow -t $HOME *
  ```
