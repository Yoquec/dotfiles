# USER TODO: rename myhost/myuser to your actual machine/username, and fill
# in your identity below (yoq.identity sets git's user.name/user.email).
{ yoq, ... }:
{
  den.hosts.aarch64-darwin.myhost.users.myuser = { };

  den.aspects.myuser.includes = [
    yoq.darwin
    (yoq.identity {
      name = "Your Name";
      email = "you@example.com";
    })
  ];
}
