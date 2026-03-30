{
  # Links:
  # https://docs.noctalia.dev/
  # https://docs.noctalia.dev/getting-started/nixos/#config-with-home-manager
  flake.homeModules.noctalia = {
    inputs,
    pkgs,
    ...
  }: let
    dotfiles = import ../../dotfiles.nix;
    module = "noctalia";
    file = "noctalia-restart.sh";
    system = pkgs.stdenv.hostPlatform.system;
    noctalia-shell = inputs.noctalia.packages.${system}.default;
  in {
    home.file = dotfiles.insertHomeLocalBin module file;

    imports = [
      inputs.noctalia.homeModules.default
    ];

    home.packages = [
      pkgs.gpu-screen-recorder # -gtk
      pkgs.iw
      pkgs.playerctl
    ];

    programs.noctalia-shell = {
      enable = true; # Default: false
      package = noctalia-shell.override {calendarSupport = true;};
    };
  };
}
