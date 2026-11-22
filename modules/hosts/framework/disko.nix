# Layout: 1G ESP /boot, 16G swap, remaining disk LUKS-encrypted ("cryptvolume")
# holding btrfs with separate /, /home, /nix subvolumes.
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
          swap = {
            size = "16G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
              # zram absorbs normal memory pressure; this
              # partition is mainly the hibernation resume target.
              priority = 5;
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
                };
              };
            };
          };
        };
      };
    };
  };
}
