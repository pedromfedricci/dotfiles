{...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "electron";
  files = ["electron-flags.conf"];
in {
  home.file = dotfiles.insertManyHomeConfig module files;
}
