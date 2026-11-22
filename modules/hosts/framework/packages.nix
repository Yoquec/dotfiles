{ burrow, ... }: {
  den.aspects.framework = {
    includes = [ burrow.blanket ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        wdisplays
        yubikey-manager
      ];
    };
  };
}
