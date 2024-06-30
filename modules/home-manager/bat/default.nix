{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "bat";
  files = ["config"];
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  programs.bat = {
    enable = true;
    package = pkgs.bat;
    extraPackages = with pkgs.bat-extras; [batdiff batgrep batman batwatch];
  };

  programs.zsh = {
    shellAliases = {
      cat = "bat";
      fzfbat = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    };
  };
}
