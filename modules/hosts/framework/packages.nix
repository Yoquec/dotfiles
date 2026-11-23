{ yoq, burrow, ... }: {
  den.aspects.framework = {
    includes = [
      burrow.fwupd
      yoq.ghostty
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
