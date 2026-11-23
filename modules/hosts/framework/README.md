# Installing `framework`

Destructive: this wipes the disk at
`/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b4cebba0e` (see
[disko.nix](./disko.nix)). Double check that id still matches before
continuing:

```sh
ls -la /dev/disk/by-id/ | grep nvme
```

From a booted NixOS minimal installer:

1. Connect to wifi.

   ```sh
   nmcli device wifi list
   nmcli device wifi connect "<SSID>" --ask
   ```

2. Clone this repo.

   ```sh
   nix-shell -p git --run "git clone git@github.com:yoquec/dotfiles.git"
   cd dotfiles
   ```

3. Partition, format and mount, via disko.

   ```sh
   sudo nix --extra-experimental-features "nix-command flakes" run \
     github:nix-community/disko -- --mode destroy,format,mount --flake .#framework
   ```

   You'll be prompted for the `cryptvolume` LUKS passphrase here (typed
   twice, to set it) — it isn't stored anywhere in this repo.

4. Install.

   ```sh
   sudo nixos-install --no-root-password --flake .#framework
   ```

   `nixos-install` will ask you to set the root password.

5. Set a password for `yoquec`, while still chrooted into `/mnt`.

   ```sh
   sudo nixos-enter --root /mnt -c 'passwd yoquec'
   ```

6. Reboot into the new system.

   ```sh
   reboot
   ```

7. Enroll a fingerprint (see [`burrow.fprint`](../../burrow/fprint.nix)).

   ```sh
   fprintd-enroll
   ```
