{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "bat";
  files = ["config"];
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  programs.bat = {
    enable = true;
    package = pkgs.bat;
  };

  programs.zsh = {
    shellAliases = {
      cat = "bat";
    };
  };
}
