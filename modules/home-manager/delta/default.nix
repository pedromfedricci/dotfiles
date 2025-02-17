{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "git";
  themes = ["themes.gitconfig" "catppuccin.gitconfig"];
  select = "catppuccin.gitconfig";
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module themes;

  home.sessionVariables.DELTA_PAGER = "less --mouse";

  programs.git.delta = {
    enable = true;
    package = pkgs.unstable.delta;
    options = {
      features = "catppuccin-mocha";
      side-by-side = true;
    };
  };

  programs.git = {
    includes = [
      {path = "~/.config/${module}/${select}";}
    ];
  };
}
