# Installing `framework`

Destructive: this wipes the disk at
`/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b4cebba0e` (see
[disko.nix](./disko.nix)). Double check that id still matches before
continuing:

```console
ls -la /dev/disk/by-id/ | grep nvme
```

From a booted NixOS minimal installer, with network up:

1. Clone this repo.

   ```sh
   nix-shell -p git --run "git clone git@github.com:yoquec/dotfiles.git"
   cd dotfiles
   ```

2. Partition, format and mount, via disko.

   ```sh
   sudo nix --extra-experimental-features "nix-command flakes" run \
     github:nix-community/disko -- --mode destroy,format,mount .#framework
   ```

   You'll be prompted for the `cryptvolume` LUKS passphrase here (typed
   twice, to set it) — it isn't stored anywhere in this repo.

3. Install.

   ```sh
   sudo nixos-install --flake .#framework
   ```

   `nixos-install` will ask you to set the root password.

4. Set a password for `yoquec`, while still chrooted into `/mnt`.

   ```sh
   nixos-enter --root /mnt -c 'passwd yoquec'
   ```

5. Reboot into the new system.

   ```sh
   reboot
   ```

6. Enroll a fingerprint (see [`burrow.fprint`](../../burrow/fprint.nix)).

   ```sh
   fprintd-enroll
   ```
