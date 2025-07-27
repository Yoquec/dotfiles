{
  config,
  pkgs,
  ...
}: let
  identity = {
    username = "yoquec";
    fullname = "Alvaro Viejo";
    email = "alvaro.viejo@yoquec.com";
  };
in {
  imports = [
    ../../modules/home
    ../../modules/identity.nix
  ];
  inherit identity;

  home.username = identity.username;
  home.homeDirectory = "/home/${identity.username}";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # TODO: Add executable scripts as overlays
    nil
    harper
    lemminx
    taplo
    texlab
    alejandra
    yaml-language-server
    vscode-langservers-extracted
    emmet-language-server
    bash-language-server
    nodePackages.prettier
    shfmt
  ];

  modules.nix.enable = true;

  # NOTE: Packages currently managed by pacman
  # programs = {
  #   lazygit.enable = true;
  #   eza.enable = true;
  #   rigpgrep.enable = true;
  # };

  programs = {
    awscli.enable = true;
  };

  home.file = {
    ".xinitrc".source = ../../dotfiles/xinit/.xinitrc;

    ".config/rofi".source = ../../dotfiles/rofi;
    ".config/dunst".source = ../../dotfiles/dunst;
    ".config/ghostty".source = ../../dotfiles/ghostty;
    ".config/redshift".source = ../../dotfiles/redshift;
    ".config/wireplumber".source = ../../dotfiles/wireplumber;

    ".config/ncspot/config.toml".source = ../../dotfiles/ncspot/config.toml;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    WIKI_HOME = "$HOME/Nextcloud/Notes/";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
