{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "git";
  file = "themes.gitconfig";
in {
  home.file = dotfiles.insertHomeConfigWithDir module file;

  programs.git.delta = {
    enable = true;
    package = pkgs.unstable.delta;
    options = {
      features = "colibri";
      side-by-side = true;
    };
  };

  programs.git = {
    includes = [
      {path = "~/.config/${module}/${file}";}
    ];
  };
}
