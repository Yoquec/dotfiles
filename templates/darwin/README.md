# yoq.darwin template

A nix-darwin host preconfigured with `yoq.darwin` from
[yoquec/dotfiles](https://github.com/yoquec/dotfiles).

## Getting started

1. Rename the placeholder host/user in `modules/hosts.nix` (`myhost`/`myuser`),
   and fill in your own name/email passed to `yoq.identity`.
2. `nix run .#write-flake` to fill in `flake.nix`'s `inputs` block, then
   `nix flake lock`.
3. `darwin-rebuild build --flake .#<your-host-name>` to try it out, then
   `darwin-rebuild switch --flake .#<your-host-name>` once happy.

`flake.nix` is generated -- don't hand-edit it. Re-run `nix run .#write-flake`
whenever yoquec/dotfiles adds a new shared input.
