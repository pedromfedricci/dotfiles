# GTK configuration.
# https://wiki.archlinux.org/title/GTK#Configuration
# https://wiki.archlinux.org/title/Cursor_themes#KDE%20(Wayland)
#
# Night Fox GTK Theme
# https://github.com/Fausto-Korpsvart/Nightfox-GTK-Theme
{pkgs, ...}: {
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];

  home.packages = [
    # pkgs.sassc
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Flat-Remix-Blue-Dark";
      package = pkgs.flat-remix-icon-theme;
    };
    # theme = {
    #   name = "Flat-Remix-GTK-Blue-Dark";
    #   package = pkgs.flat-remix-gtk;
    # };
    # theme = {
    #   # BL: borderless, LB: legacy buttom
    #   name = "Nightfox-Dark-BL-LB";
    #   package = pkgs.nigthfox-gtk-theme;
    # };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
    };
  };
}
