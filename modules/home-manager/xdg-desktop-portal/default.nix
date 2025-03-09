{pkgs, ...}: {
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-gtk # GTK
    # pkgs.xdg-desktop-portal-gnome # GNOME
    pkgs.xdg-desktop-portal-kde # KDE
    # pkgs.xdg-desktop-portal-lxqt # LXQt
    # pkgs.xdg-desktop-portal-pantheon # Pantheon (Elementary OS)
    pkgs.xdg-desktop-portal-wlr # wlroots
    # pkgs.xdg-desktop-portal-dde # Deepin
    # pkgs.xdg-desktop-portal-xapp # Xapp (Cinnamon, MATE, Xfce)
    # pkgs.xdg-desktop-portal-cosmic # COSMIC
    # pkgs.xdg-desktop-portal-hyprland # Hyprland
  ];
}
