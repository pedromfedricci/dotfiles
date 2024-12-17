{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "git";
  themes = "themes.gitconfig";
in {
  home.file = dotfiles.insertHomeConfigWithDir module themes;

  home.sessionVariables.DELTA_PAGER = "less --mouse";

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
      {path = "~/.config/${module}/${themes}";}
    ];
  };
}
