{
  lib,
  config,
  ...
}: let
  icons = {
    aws.symbol = "  ";
    buf.symbol = " ";
    bun.symbol = " ";
    c.symbol = " ";
    cpp.symbol = " ";
    cmake.symbol = " ";
    conda.symbol = " ";
    crystal.symbol = " ";
    dart.symbol = " ";
    deno.symbol = " ";
    docker_context.symbol = " ";
    elixir.symbol = " ";
    elm.symbol = " ";
    fennel.symbol = " ";
    fossil_branch.symbol = " ";
    gcloud.symbol = "  ";
    git_branch.symbol = " ";
    golang.symbol = " ";
    guix_shell.symbol = " ";
    haskell.symbol = " ";
    haxe.symbol = " ";
    hg_branch.symbol = " ";
    java.symbol = " ";
    julia.symbol = " ";
    kotlin.symbol = " ";
    lua.symbol = " ";
    memory_usage.symbol = "󰍛 ";
    meson.symbol = "󰔷 ";
    nim.symbol = "󰆥 ";
    nix_shell.symbol = " ";
    nodejs.symbol = " ";
    ocaml.symbol = " ";
    package.symbol = "󰏗 ";
    perl.symbol = " ";
    php.symbol = " ";
    pijul_channel.symbol = " ";
    pixi.symbol = "󰏗 ";
    python.symbol = " ";
    rlang.symbol = "󰟔 ";
    ruby.symbol = " ";
    rust.symbol = "󱘗 ";
    scala.symbol = " ";
    swift.symbol = " ";
    zig.symbol = " ";
    gradle.symbol = " ";
    directory.read_only = " 󰌾";
    hostname = {ssh_symbol = " ";};
    git_commit = {tag_symbol = " ";};
    os.symbols = {
      Alpaquita = " ";
      Alpine = " ";
      AlmaLinux = " ";
      Amazon = " ";
      Android = " ";
      Arch = " ";
      Artix = " ";
      CachyOS = " ";
      CentOS = " ";
      Debian = " ";
      DragonFly = " ";
      Emscripten = " ";
      EndeavourOS = " ";
      Fedora = " ";
      FreeBSD = " ";
      Garuda = "󰛓 ";
      Gentoo = " ";
      HardenedBSD = "󰞌 ";
      Illumos = "󰈸 ";
      Kali = " ";
      Linux = " ";
      Mabox = " ";
      Macos = " ";
      Manjaro = " ";
      Mariner = " ";
      MidnightBSD = " ";
      Mint = " ";
      NetBSD = " ";
      NixOS = " ";
      Nobara = " ";
      OpenBSD = "󰈺 ";
      openSUSE = " ";
      OracleLinux = "󰌷 ";
      Pop = " ";
      Raspbian = " ";
      Redhat = " ";
      RedHatEnterprise = " ";
      RockyLinux = " ";
      Redox = "󰀘 ";
      Solus = "󰠳 ";
      SUSE = " ";
      Ubuntu = " ";
      Unknown = " ";
      Void = " ";
      Windows = "󰍲 ";
    };
  };
in {
  options.modules.development.starship.enable = lib.mkEnableOption "Enable starship";

  config = lib.mkIf config.modules.development.starship.enable {
    programs.starship = {
      enable = true;
      settings =
        lib.recursiveUpdate
        {
          direnv = {
            disabled = false;
            format = ''[$symbol$loaded]($style) '';
          };
          nix_shell.format = ''via [$symbol$state]($style) '';
        }
        icons;
      enableZshIntegration = config.modules.development.zsh.enable;
    };
  };
}
