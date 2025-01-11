# Hyprland docs:
# https://wiki.hyprland.org/
{
  pkgs,
  inputs,
  ...
}: let
  terminal = "alacritty";
  fileManager = "nautilus";
  hyprland = inputs.hyprland.packages.${pkgs.system};
  hyprland-plugins = inputs.hyprland-plugins.packages.${pkgs.system};
in {
  # Optional, hint electron apps to use wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.${terminal}.enable = true;

  programs.waybar = {
    enable = true;
    systemd.enable = false; # Default: false.
    # settings = {};
    # style = {};
  };

  services = {
    hyprpaper.enable = true;
    hypridle.enable = false;
  };

  home.packages = with pkgs; [
    hyprcursor
    hyprpolkitagent
  ];

  # XDPH doesn’t implement a file picker. For that, it is recommended to install
  # xdg-desktop-portal-gtk alongside XDPH.
  # https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.hyprland;
    # Conflicts with UWSM set on nixos module.
    # Link: https://wiki.hyprland.org/Useful-Utilities/Systemd-start/#installation
    systemd.enable = false;
    # Enable the use of `source` entries at the top of the config.
    sourceFirst = true; # Default: true
    # Official plugins: https://github.com/hyprwm/hyprland-plugins
    plugins = with hyprland-plugins; [
      # hyprbars
      hyprexpo
      hyprtrails
    ];
    importantPrefixes = [];
    settings = {
      source = [
        "~/.config/hypr/default.conf"
      ];
      "$terminal" = "${terminal}";
      "$fileManager" = "${fileManager}";
    };
  };
}
