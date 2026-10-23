{ ... }:

let
  logo = ''
    ▌▌▛▌▛▌
    ▙▌▙▌▙▌
    ▄▌   ▌

    Made with ❤️ by Alvaro Viejo (a.k.a. yoquec)
  '';

  withLogo = text: logo + "\n\n" + text;
in
{
  flake.templates.darwin = {
    path = ../templates/darwin;
    description = "A nix-darwin host preconfigured with yoq.darwin (aerospace, nix settings, betterdisplay, theme, etc.)";
    welcomeText = withLogo ''
      Next steps:
      1. Rename the placeholder host/user in `modules/hosts.nix` (`myhost`/`myuser`),
         and fill in your own name/email passed to `yoq.identity`.
      2. `nix run .#write-flake` to fill in `flake.nix`'s `inputs` block, then
         `nix flake lock`.
      3. `darwin-rebuild build --flake .#<your-host-name>` to try it out,
         then `darwin-rebuild switch --flake .#<your-host-name>` once happy.
    '';
  };
}
