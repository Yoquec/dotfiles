# `iwd` as NetworkManager backend

The arch wiki [recommends using `iwd` as the backend for NetworkManager](https://wiki.archlinux.org/title/Framework_Laptop_13_(AMD_Ryzen_7040_Series)#Wi-Fi). Configs contained in the present package are pertinent to this prupose.

It is important to note that this package should be installed setting the root directory (`/`) as target

```bash
cd $HOME/.local/dotfiles && stow -t / iwd
```
