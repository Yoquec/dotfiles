{ burrow, ... }: {
  den.aspects.framework = {
    includes = [
      burrow.blanket
      burrow.claude-code
    ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        wdisplays
        yubikey-manager
      ];
    };
  };
}
