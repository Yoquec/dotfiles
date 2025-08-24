{lib, ...}: {
  options.identity = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "Your username as shown by `id -un`";
    };
    fullname = lib.mkOption {
      type = lib.types.str;
      description = "Your full name for use in Git config";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "Your email for use in Git config";
    };
  };
}
