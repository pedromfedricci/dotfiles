{
  flake.nixosModules.noctalia = {inputs, ...}: {
    # Calendar events support.
    # https://mynixos.com/nixpkgs/option/services.gnome.evolution-data-server
    # https://docs.noctalia.dev/getting-started/nixos/#calendar-events-support
    services.gnome.evolution-data-server.enable = true;

    imports = [
      inputs.noctalia.nixosModules.default
    ];

    # NOTE: Better enable on home-manager. Default: false.
    services.noctalia-shell.enable = false;
  };
}
