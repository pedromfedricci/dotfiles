{
  pkgs,
  inputs,
  ...
}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "helix";
  files = ["config.toml" "languages.toml" "themes/nightfox.toml" "themes/catppuccin_mocha.toml"];
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.helix;
    # package = pkgs.unstable.helix;
    defaultEditor = true;
  };
}
