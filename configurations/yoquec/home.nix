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
  # };

  programs = {
    awscli.enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
    WIKI_HOME = "$HOME/Nextcloud/Notes/";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
