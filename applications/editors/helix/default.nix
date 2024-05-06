{
  pkgs,
  inputs,
  ...
}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "helix";
  files = ["config.toml" "languages.toml" "themes/nightfox.toml"];
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = inputs.helix.packages.${pkgs.system}.helix;
  };
}
