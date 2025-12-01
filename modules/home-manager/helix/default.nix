{
  pkgs,
  inputs,
  ...
}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "helix";
  files = ["config.toml" "languages.toml" "themes/nightfox.toml" "themes/catppuccin_mocha.toml"];
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${system}.helix;
    # package = pkgs.unstable.helix;
    defaultEditor = true;
  };
}
