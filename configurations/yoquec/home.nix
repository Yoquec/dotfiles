{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.username = "yoquec";
  home.homeDirectory = "/home/yoquec";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
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
  #   yazi.enable = true;
  #   lazygit.enable = true;
  #   eza.enable = true;
  #   rigpgrep.enable = true;
  # };

  programs = {
    awscli.enable = true;
    bat = {
      enable = true;
      config.theme = "base16";
    };
  };

  home.file = {
    ".config/rofi".source = ../../dotfiles/rofi;
    ".config/dunst".source = ../../dotfiles/dunst;
    ".config/ghostty".source = ../../dotfiles/ghostty;

    # TODO: Add wallpaper thorugh overlay
    ".config/i3".source = ../../dotfiles/i3;
    ".config/i3blocks".source = ../../dotfiles/i3blocks;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
    WIKI_HOME = "$HOME/Nextcloud/Notes/";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
