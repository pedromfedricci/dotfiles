# This is your home-manager configuration file
# Use this to configure your home environment (it replaces
# ~/.config/nixpkgs/home.nix).
{
  pkgs,
  inputs,
  outputs,
  user,
  ...
}: let
  modules = ../../modules/home-manager;
in {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    (modules + "/alacritty")
    (modules + "/bat")
    (modules + "/devenv")
    (modules + "/delta")
    (modules + "/direnv")
    (modules + "/git")
    (modules + "/helix")
    (modules + "/lsd")
    (modules + "/python")
    (modules + "/rust")
    (modules + "/starship")
    (modules + "/yazi")
    (modules + "/zellij")
    (modules + "/zoxide")
    (modules + "/zsh")
  ];

  # Configuration of the Nix Package collection.
  nixpkgs = {
    # You can add overlays here.
    overlays = [
      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })

      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.stable-packages
    ];
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user.username;
  home.homeDirectory = user.homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # It is sometimes useful to fine-tune packages, for example, by applying
    # overrides. You can do that directly here, just don't forget the
    # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # fonts?
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    #
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Hardware utilities.
    dmidecode
    # fwupd
    inxi
    lshw
    mtools
    pciutils
    wirelesstools

    # System utilities.
    alejandra # inputs.alejandra.defaultPackage.${pkgs.system}
    cloc
    curl
    devcontainer
    dua
    entr
    erlang # Couldn't install it via asdf-vm.
    fd
    ffmpegthumbnailer
    gh
    gnumake
    htop
    jq
    mold-wrapped
    nasm
    nil
    nnn
    podman
    poppler
    ripgrep
    stow
    tree
    wget
    xorriso

    # Terminal applications.
    fzf
    nushell
    podman-tui
    zsh

    # Graphical applications.
    stable.discord
    stable.firefox
    stable.libreoffice
    stable.spotify
    stable.thunderbird
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Extra directories to add to PATH.
  #
  # These directories are added to the PATH variable in a double-quoted context,
  # so expressions like $HOME are expanded by the shell. However, since expressions
  # like ~ or * are escaped, they will end up in the PATH verbatim.
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
