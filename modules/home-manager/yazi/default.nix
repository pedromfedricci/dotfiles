{
  pkgs,
  inputs,
  ...
}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "yazi";
  files = ["theme.toml"];
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  programs.yazi = {
    enable = true;
    # package = inputs.yazi.packages.${pkgs.system}.yazi;
    package = pkgs.unstable.yazi;
    enableZshIntegration = true; # No plugin support by ohmyzsh. 
  };
}
