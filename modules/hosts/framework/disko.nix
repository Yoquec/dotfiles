# Layout: 1G ESP, LUKS2 ("cryptvolume") holding btrfs with /, /home, /nix,
# /swap subvolumes. No resume=/resume_offset= kernel params: systemd
# auto-detects the swapfile's offset via the HibernateLocation EFI var, and
# setting them manually would override that. See disko#651 / nixpkgs#276374.
{ burrow, ... }:
{
  den.aspects.framework = {
    includes = [
      burrow.disko
    ];

    nixos.zramSwap = {
      enable = true;
      priority = 100;
      memoryPercent = 50;
      algorithm = "zstd";
    };

    # needed for the hibernate-resume offset auto-detection above.
    nixos.boot.initrd.systemd.enable = true;

    nixos.swapDevices = [
      {
        device = "/swap/swapfile";
        size = 32 * 1024; # MiB, >= installed RAM for hibernation to be reliable.
        priority = 5; # zram (priority 100 above) is preferred for routine swapping.
      }
    ];

    nixos.disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b4cebba0e";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptvolume";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/rootfs".mountpoint = "/";
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  # swapfile lives here; left uncompressed (swapfiles must be nocow).
                  "/swap" = {
                    mountpoint = "/swap";
                    mountOptions = [ "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
