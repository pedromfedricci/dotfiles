{ pkgs, user, ... }:
let
  source = {module, path}: ./config + "/${module}/.config/${module}/${path}";
  target = {module, path}: "${user.homeDirectory}/.config/${module}/${path}";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #
  home.username = user.username;
  home.homeDirectory = user.homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  #
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  #
  home.packages = with pkgs; [
    # It is sometimes useful to fine-tune packages, for example, by applying
    # overrides. You can do that directly here, just don't forget the
    # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # fonts?
    #
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    #
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Hardware utilities.
    #
    inxi
    lshw
    pciutils
    wirelesstools

    # System utilities.
    #
    asdf
    bat
    clang
    devcontainer
    direnv
    dua
    curl
    gh
    gnumake
    htop
    qemu
    lsd
    mold-wrapped
    nil
    podman
    ripgrep
    rustup
    starship
    stow
    tree
    wget
    zoxide

    # Terminal applications.
    #
    fzf
    helix
    nushell
    podman-tui
    zellij
    zsh

    # Graphical applications.
    #
    alacritty
    # firefox
    thunderbird
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  #
  home.file = {
    # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    #
    # ".screenrc".source = dotfiles/screenrc;

    # You can also set the file content immediately.
    #
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    "${target{module="alacritty";path="alacritty.toml";}}".source = source{module="alacritty";path="alacritty.toml";};
    "${target{module="alacritty";path="themes/nightfox.toml";}}".source = source{module="alacritty";path="themes/nightfox.toml";};
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pdmfed/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  #
  programs.home-manager.enable = true;

  programs.alacritty = {
    enable = true;
    # settings = {
    #   cursor.style = lib.mkForce "Block";
    # };
  };

  # programs.bat = {
  #   enable = true;
  # };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # enableZshIntegration = true;
  };

  # programs.firefox = {
  #   enable = true;
  #   nativeMessagingHosts = [ pkgs.gnome-browser-connector ];
  # };

  programs.git = {
    enable = true;
    userName = user.userName;
    userEmail = user.userEmail;
    signing = {
      key = null;
      signByDefault = true;
    };
  };

  # programs.helix = {
  #   enable = true;
  #   defaultEditor = true;
  # };

  # programs.starship = {
  #   enable = true;
  #   # enableZshIntegration = true;
  # };

  # programs.zellij = {
  #   enable = true;
  #   # enableZshIntegration = true;
  # };

  # programs.zoxide = {
  #   enable = true;
  #   # enableZshIntegration = true;
  # };

  programs.zsh = {
    enable = true;
    sessionVariables = {
      SHELL = "zsh";
      ZOXIDE_CMD_OVERRIDE = "cd";
    };
    shellAliases = {
      cat = "bat";
      ls = "lsd";
      ll = "lsd -l";
      la = "lsd -a";
      lt = "lsd --tree";
      lla = "lsd -la";
    };
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "asdf"
        # "bun"
        "direnv"
        "docker"
        "git"
        "gh"
        # "helm"
        "podman"
        "python"
        "rust"
        "ripgrep"
        "starship"
        # "kubectl"
        "zoxide"
      ];
    };
  };
}
