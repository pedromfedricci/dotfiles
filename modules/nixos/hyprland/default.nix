{
  pkgs,
  inputs,
  ...
}: let
  hyprland = inputs.hyprland.packages.${pkgs.system};
in {
  programs.hyprland = {
    enable = true;
    # Link: https://wiki.hyprland.org/Useful-Utilities/Systemd-start/#installation
    withUWSM = true;
    package = hyprland.hyprland;
    # Make sure to also set the portal package, so that they are in sync.
    portalPackage = hyprland.xdg-desktop-portal-hyprland;
  };

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = [
    # Required by the default Hyprland config.
    pkgs.kitty
  ];
}
