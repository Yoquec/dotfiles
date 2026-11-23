{ yoq, burrow, ... }: {
  den.aspects.framework = {
    includes = [
      yoq.ghostty
      burrow.fwupd
      burrow.nextcloud
      burrow.blanket
      burrow.keepassxc
      burrow.ssh-agent
      burrow.claude-code
    ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        jq
        pciutils
        wdisplays
        signal-desktop
        yubikey-manager
      ];
    };
  };
}
