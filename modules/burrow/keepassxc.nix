{ yoq, burrow, ... }: {
  burrow.keepassxc = {
    includes = [
      yoq.theme
      burrow.graphics
    ];
    homeManager.programs.keepassxc.enable = true;
  };
}
