# USER TODO: rename myhost/myuser to your actual machine/username, and fill
# in your identity below (yoq.identity sets git's user.name/user.email).
{ den, yoq, ... }:
{
  den.hosts.aarch64-darwin.myhost.users.myuser.classes = [ "homeManager" ];

  den.aspects.myuser.includes = [
    den.batteries.define-user
    den.batteries.primary-user
    yoq.darwin
    (yoq.identity {
      name = "Your Name";
      email = "you@example.com";
    })
  ];
}
