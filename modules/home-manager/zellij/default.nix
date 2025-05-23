{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "zellij";
  files = ["config.kdl" "layouts/zjstatus.kdl" "layouts/zjstatus.swap.kdl"];
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  programs.zellij = {
    enable = true;
    package = pkgs.unstable.zellij;
  };
}
