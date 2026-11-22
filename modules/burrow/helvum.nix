{ burrow, ... }: {
  burrow.helvum = {
    includes = [ burrow.audio ];

    # TODO: add the helvum package through home manager when moved to a release that adds it
  };
}
