{
  pkgs,
  inputs,
  ...
}: let
  hyprland = inputs.hyprland.packages.${pkgs.system};
  hyprland-plugins = inputs.hyprland-plugins.packages.${pkgs.system};
in {
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.hyprland;

    # Official plugins: https://github.com/hyprwm/hyprland-plugins
    plugins = with hyprland-plugins; [
      # hyprbars
      hyprexpo
      hyprtrails
    ];
  };

  # Optional, hint electron apps to use wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # Required by default Hyprland config.
  programs.kitty.enable = true;
}
