# USER TODO: rename host/user to your actual machine/username, and fill
# in your identity below.
{ den, yoq, ... }:
let
  host = "myhost";
  user = "myuser";
  name = "Your Name";
  email = "you@example.com";
in
{
  den.aspects."${host}".includes = [ yoq.darwin ];
  den.hosts.aarch64-darwin."${host}".users."${user}".classes = [ "homeManager" ];

  den.aspects."${user}".includes = [
    yoq.development
    den.batteries.define-user
    den.batteries.primary-user
    den.batteries.host-aspects
    (yoq.identity { inherit name email; })
  ];
}
