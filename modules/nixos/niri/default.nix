{pkgs, ...}: {
  # Links:
  # https://mynixos.com/nixpkgs/options/programs.niri
  programs.niri = {
    enable = true; # Default: false
    package = pkgs.niri;
    useNautilus = true; # Default: true
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };

  # Some document viewer, Evince from GNOME.
  # Link: https://mynixos.com/nixpkgs/options/programs.evince
  programs.evince.enable = true;

  # Set some display manager.
  services.displayManager.gdm.enable = true;

  # Enable GVfs service, userspace virtual filesystem.
  # Link: https://mynixos.com/nixpkgs/options/services.gvfs
  services.gvfs.enable = true;
  # Enable udisk2 service, storage manipulation DBus service.
  # Link: https://mynixos.com/nixpkgs/option/services.udisks2
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    celluloid
    gedit
    gnome-system-monitor
    libnotify
    nautilus
    wev
    xwayland-satellite
    wl-clipboard
  ];

  environment.sessionVariables = {
    # Hint electron apps to use wayland.
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  # Links:
  # https://niri-wm.github.io/niri/Important-Software.html#portals
  # https://niri-wm.github.io/niri/Screencasting.html#overview
  # Fix screencast:
  # https://github.com/niri-wm/niri/issues/2116#issuecomment-3115238985
  xdg.portal = {
    enable = true;

    extraPortals = [
      # Implements most of the basic functionality.
      pkgs.xdg-desktop-portal-gtk
      # Required for screencasting on Niri.
      pkgs.xdg-desktop-portal-gnome
      # Only implements ScreenCast and Screenshot.
      pkgs.xdg-desktop-portal-wlr
    ];

    # Check:
    # grep -r "Interfaces" /run/current-system/sw/share/xdg-desktop-portal/portals/gnome.portal
    config.niri = {
      default = ["gnome" "gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = ["wlr" "gnome"];
      "org.freedesktop.impl.portal.Screenshot" = ["wlr" "gnome"];
    };
  };

  # Links:
  # https://niri-wm.github.io/niri/Important-Software.html#portals
  # https://mynixos.com/home-manager/options/services.gnome-keyring
  services.gnome.gnome-keyring = {
    enable = true;
  };

  # NOTE: Already set.
  # environment.sessionVariables = {
  #   XDG_CURRENT_DESKTOP = "niri";
  #   XDG_SESSION_TYPE = "wayland";
  #   XDG_SESSION_DESKTOP = "niri";
  # };
}
