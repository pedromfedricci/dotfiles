{
  flake.homeModules.niri = {...}: let
    dotfiles = import ../../dotfiles.nix;
    module = "niri";
    binFile = "niri-toggle-edp.sh";
    configFiles = ["noctalia.kdl" "config.kdl"];
  in {
    home.file =
      dotfiles.insertHomeLocalBin module binFile
      // dotfiles.insertManyHomeConfigWithDir module configFiles;
  };
}
